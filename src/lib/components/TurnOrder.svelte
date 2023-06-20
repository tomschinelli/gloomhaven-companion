<script lang="ts">
    import {flip} from 'svelte/animate'
    import {dndzone} from 'svelte-dnd-action'
    import type {Character} from "$lib/Character";
    import TurnOrderItem from "$lib/components/TurnOrderItem.svelte";
    import {createEventDispatcher} from "svelte";

    const dispatch = createEventDispatcher();

    export let characters: Character[] = []
    export let editMode = false


    const flipDuration = 200;
    const handleConsider = (evt: CustomEvent<DndEvent<Character>>) => {
        characters = evt.detail.items
    };
    const handleFinalize = (evt: CustomEvent<DndEvent<Character>>) => {
        characters = evt.detail.items
    };

    let templateColumns = '1fr 1fr 1fr 1fr';
    $: if(characters.length > 0) {
        const columnItems = characters.map(x=> x.type== "hero"? '1fr': "35px")
        // keep add button small
        while (columnItems.length < 4){
            columnItems.push("1fr")
        }
        if(editMode)columnItems.push("1fr")
        templateColumns = columnItems.join(" ")
    }

    const onAdd = () => dispatch("add");
    const onDelete = (id:string) => dispatch("delete", {
        id: id
    });

</script>
<div use:dndzone="{{items:characters, dragDisabled: editMode, dropDisable:editMode}}"
     on:consider="{handleConsider}"
     on:finalize="{handleFinalize}"
     class="container"
     style:grid-template-columns="{templateColumns}"
>
    {#each characters as character (character.id)}
        <div animate:flip={{duration: flipDuration}}>
            <TurnOrderItem character={character} on:delete={()=>onDelete(character.id)} />
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
        /*grid-template-columns: repeat(auto-fill, calc(1 / var(--character-count) * 100% - 10px));*/
        /*grid-template-columns: 35px 35px 1fr 1fr 1fr;*/

        justify-content: center;
        gap: 10px;
        padding: 10px 5px;
        box-sizing: border-box;
    }

</style>