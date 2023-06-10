<script lang="ts">
    import CharacterSelectionDialog from "../components/CharacterSelectionDialog.svelte";
    import GHButton from "../components/GHButton.svelte";
    import type {Character} from "../models/character";
    import TurnOrderItem from "../components/TurnOrderItem.svelte";

    let characterSelection: CharacterSelectionDialog

    let characters: Character[] = [];

    function addCharacter( c: Character){
        characterSelection.close();
        characters = [...characters, c]

    }
    function openCharacterSelection(){
        characterSelection.open();
    }


</script>
<CharacterSelectionDialog on:select={e =>addCharacter(e.detail.character)} bind:this={characterSelection}/>

<div class="container" style={'--character-count: '+(characters.length+1)}>
    {#each characters as character}
        <TurnOrderItem character={character}/>
    {/each}
    <TurnOrderItem on:click={openCharacterSelection}/>

</div>


<style>
.container{
    min-height: 100vh;
    position: relative;
    display: grid;
    grid-template-columns: repeat(auto-fill, calc( 1/var(--character-count) * 100% - 10px ));
    justify-content: center;
    gap: 10px;
    padding: 10px 5px;
    box-sizing: border-box;
}
</style>