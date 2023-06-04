<script lang="ts">
    import CharacterSelectionDialog from "../components/CharacterSelectionDialog.svelte";
    import GHButton from "../components/GHButton.svelte";
    let characterSelection: CharacterSelectionDialog


</script>

<div>Characters</div>
<GHButton on:click={() => characterSelection.open()}>add</GHButton>
<CharacterSelectionDialog bind:this={characterSelection}/>


<style>
    :global(html){
        background: radial-gradient(#363642, #1d1d28) fixed;
        color: #dddddd;
        font-family:  sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }
    :global(dialog){
        color: #dddddd;
        background: #171717 fixed;
        border: 0;
        margin: 0;
        padding: 0;

    }

    dialog::backdrop {
        backdrop-filter: blur(1px);
    }
</style>