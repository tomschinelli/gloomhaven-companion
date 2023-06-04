<script lang="ts">
    import {CharacterApi} from "../api/character";
    import { swipe } from 'svelte-gestures';


    import CharacterCard from "./CharacterCard.svelte";

    const characterApi = new CharacterApi()
    const characters = characterApi.getCharacters(["gloomhaven"])

    let handle: HTMLDialogElement

    export const open = () => {
        handle.showModal()
    }
    export const onCloseSwipe = (event:CustomEvent) => {
        if(event.detail.direction != "right")return;
        handle.close()
    }
</script>


<dialog bind:this={handle} use:swipe={{timeframe: 300, minSwipeDistance: 60,touchAction: 'pan-y' }} on:swipe={onCloseSwipe}>
    <div class="cards">
        {#each characters as character }
            <CharacterCard character={character}/>
        {/each}
    </div>

</dialog>


<style>
    dialog {
        max-height: 100%;
        max-width: 100%;
        overflow: auto;
    }


    .cards{
        display: grid;
        gap: 20px;
        padding: 20px;
        grid-template-columns: 1fr 1fr 1fr;
    }
</style>