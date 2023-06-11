<script lang="ts">
    import CharacterSelectionDialog from "$lib/components/CharacterSelectionDialog.svelte";
    import type {Character} from "$lib/Character";
    import TurnOrder from "$lib/components/TurnOrder.svelte";

    let characters: Character[] = [];
    const addCharacter = (c: Character) => {
        characterSelection.close();
        characters = [...characters, c]

    };

    let characterSelection: CharacterSelectionDialog
    const openCharacterSelection = () => {
        characterSelection.open();
    };

    let forceEditMode = true;
    $: editmode = characters.length === 0 || forceEditMode;
</script>
<div on:click={()=>forceEditMode = !forceEditMode}>{editmode}</div>
<CharacterSelectionDialog on:select={e =>addCharacter(e.detail.character)} bind:this={characterSelection}/>
<TurnOrder bind:characters={characters} editMode="{editmode}" on:add={openCharacterSelection} />
