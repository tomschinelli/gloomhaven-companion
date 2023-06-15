/// <reference types="@sveltejs/kit" />
import { build, files, version } from '$service-worker';

// Create a unique cache name for this deployment
const CACHE = `cache-${version}`;

const ASSETS = [
    ...build, // the app itself
    ...files  // everything in `static`
];

self.addEventListener('install', (event) => {
    // Create a new cache and add all files to it
    async function addFilesToCache() {
        const cache = await caches.open(CACHE);
        await cache.addAll(ASSETS);
    }

    event.waitUntil(addFilesToCache());
});

self.addEventListener('activate', (event) => {
    // Remove previous cached data from disk
    async function deleteOldCaches() {
        for (const key of await caches.keys()) {
            if (key !== CACHE) await caches.delete(key);
        }
    }

    event.waitUntil(deleteOldCaches());
});

/**
 * Fetch the asset from the network and store it in the cache.
 * Fall back to the cache if the user is offline.
 */
async function fetchAndCache(request) {
    const cache = await caches.open(`offline${timestamp}`);

    try {
        const response = await fetch(request);
        cache.put(request, response.clone());
        return response;
    } catch (err) {
        const response = await cache.match(request);
        if (response) return response;

        throw err;
    }
}

self.addEventListener('fetch', (event) => {
    if (event.request.method !== 'GET' || event.request.headers.has('range')) return;

    const url = new URL(event.request.url);

    // don't try to handle e.g. data: URIs
    const isHttp = url.protocol.startsWith('http');
    const isDevServerRequest =
        url.hostname === self.location.hostname && url.port !== self.location.port;
    const isStaticAsset = url.host === self.location.host && staticAssets.has(url.pathname);
    const skipBecauseUncached = event.request.cache === 'only-if-cached' && !isStaticAsset;

    if (isHttp && !isDevServerRequest && !skipBecauseUncached) {
        event.respondWith(
            (async () => {
                // always serve static files and bundler-generated assets from cache.
                // if your application has other URLs with data that will never change,
                // set this variable to true for them and they will only be fetched once.
                const cachedAsset = isStaticAsset && (await caches.match(event.request));

                return cachedAsset || fetchAndCache(event.request);
            })()
        );
    }
});