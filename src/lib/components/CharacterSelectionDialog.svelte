<script lang="ts">
    import {swipe} from 'svelte-gestures';

    import CharacterCard from "./CharacterCard.svelte";
    import {createEventDispatcher} from "svelte";
    import {CharacterApi} from "$lib/CharacterApi";
    import type {Character} from "$lib/Character";
    import Button from "$lib/components/Button.svelte";
    import type {Expansion} from "$lib/expansion";

    const characterApi = new CharacterApi()
    let characters: Character[] = []
    let activeFilter = 'heros'
    let activeExpansions: Expansion[] = ["gloomhaven"]

    let handle: HTMLDialogElement
    const dispatch = createEventDispatcher();

    export const open = () => {
        loadData()
        handle.showModal()
    }
    export const close = () => {
        handle.close()
    }
    const setFilter = (value: string) => {
        activeFilter = value
        loadData()
    }
    const loadData = () => {
        if (activeFilter == 'heros') {
            characters = characterApi.getCharacters(activeExpansions)
        }
        if (activeFilter == 'enemies') {
            characters = characterApi.getEnemies(activeExpansions)
        }
    }

    export const onCloseSwipe = (event: CustomEvent) => {
        if (event.detail.direction != "right") return;
        handle.close()
    }

    const onSelect = (c: Character) => {
        dispatch("select", {
            character: c
        })
    };


</script>


<dialog bind:this={handle} use:swipe={{timeframe: 300, minSwipeDistance: 60,touchAction: 'pan-y' }}
        on:swipe={onCloseSwipe}>
    <div class="filters">
        <Button on:click={()=>setFilter('heros')} active="{activeFilter==='heros'}">HEROS</Button>
        <Button on:click={()=>setFilter('enemies')} active="{activeFilter==='enemies'}">ENEMIES</Button>
    </div>
    <div class="cards">
        {#each characters as character }
            <CharacterCard on:click={()=>onSelect(character)} character={character}/>
        {/each}
    </div>

</dialog>


<style>
    dialog {
        max-height: 100%;
        max-width: 100%;
        width: 100%;
        overflow: auto;
    }

    .filters {
        top: 0;
        position: sticky;
        background: inherit;

        display: grid;
        grid-template-columns: 1fr 1fr;
        padding: 1rem;
        gap: 1rem;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 1);

    }

    .cards {
        display: grid;
        gap: 20px;
        padding: 0 20px 20px;
        grid-template-columns: repeat(3, 1fr);
    }
</style>