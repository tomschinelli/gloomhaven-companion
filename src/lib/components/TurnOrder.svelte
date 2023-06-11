<script lang="ts">
    import {flip} from 'svelte/animate'
    import {dndzone} from 'svelte-dnd-action'
    import type {Character} from "$lib/Character";
    import TurnOrderItem from "$lib/components/TurnOrderItem.svelte";
    import {createEventDispatcher} from "svelte";

    const dispatch = createEventDispatcher();

    export let characters: Character[] = []
    export let editMode = false
    $: itemCount = editMode ? characters.length + 1 : characters.length;


    const flipDuration = 200;
    const handleConsider = (evt: CustomEvent<DndEvent<Character>>) => {
        characters = evt.detail.items
    };
    const handleFinalize = (evt: CustomEvent<DndEvent<Character>>) => {
        characters = evt.detail.items
    };


    const onAdd = () => dispatch("add");

</script>
<div use:dndzone="{{items:characters}}"
     on:consider="{handleConsider}"
     on:finalize="{handleFinalize}"
     class="container"
     style={'--character-count: '+(itemCount)}
>
    {#each characters as character (character.id)}
        <div animate:flip={{duration: flipDuration}}>
            <TurnOrderItem character={character} />
        </div>
    {/each}

    {#if editMode}
        <TurnOrderItem on:click={onAdd}/>
    {/if}

</div>


<style>
    .container {
        min-height: 100vh;
        position: relative;
        display: grid;
        grid-template-columns: repeat(auto-fill, calc(1 / var(--character-count) * 100% - 10px));
        justify-content: center;
        gap: 10px;
        padding: 10px 5px;
        box-sizing: border-box;
    }

</style>