<script lang="ts">
    import CharacterSelectionDialog from "$lib/components/CharacterSelectionDialog.svelte";
    import type {Character} from "$lib/Character";
    import TurnOrder from "$lib/components/TurnOrder.svelte";
    import IconButton from "$lib/components/IconButton.svelte";
    import {iconSelector} from "$lib/IconSelector";

    let characters: Character[] = [];
    const addCharacter = (c: Character) => {
        characterSelection.close();
        characters = [...characters, c]
    };
    const deleteCharacter = (id: string) => {
        characters = characters.filter(x => x.id != id)
    };

    let characterSelection: CharacterSelectionDialog
    const openCharacterSelection = () => {
        characterSelection.open();
    };

    let forceEditMode = true;
    $: editmode = characters.length === 0 || forceEditMode;
    $: modeIcon = editmode ? iconSelector.view : iconSelector.edit;
</script>

<CharacterSelectionDialog
        on:select={e =>addCharacter(e.detail.character)}
        currentCharacters="{characters}"
        bind:this={characterSelection}
/>
<TurnOrder bind:characters={characters}
           editMode="{editmode}"
           on:add={openCharacterSelection}
           on:delete={evt=>deleteCharacter(evt.detail.id)}
/>
<div class="mode">
    <IconButton on:click={()=>forceEditMode=!forceEditMode} icon="{modeIcon}"/>
</div>

<style>
    .mode {
        position: absolute;
        top: 0;
        right: 0;
        padding: 1rem;

    }
</style>