<script lang="ts">
    import type {Character} from "../models/character";
    import CharacterSelectionDialog from "./CharacterSelectionDialog.svelte";
    import GHButton from "./GHButton.svelte";

    export let character: Character;

</script>

<div class="wrapper" on:click class:placeholder="{!character}">
    {#if character}
        <img class="image" src={character.backImage} alt={character.name}>
    {:else}
        <GHButton>add</GHButton>
    {/if}


</div>

<style lang="scss">
    .wrapper{
        height: 100%;
        display: inline-block;
        &.placeholder {
          border: 2px dashed rgba(grey, 0%);
          background: rgba(grey, 0%);
          animation: pulse 2s infinite;

          display: flex;
          justify-content: center;
            align-items: center;
        }
    }
    img {
        width: 100%;
        background:blue;
        height: 100%;
        object-fit: cover;
        object-position: left;
    }

    @keyframes pulse {
      0% {
        background: rgba(grey, 0%);
      }

      70% {
        background: rgba(grey, 20%);
        border: 2px dashed rgba(grey, 60%);
      }

      100% {
        background: rgba(grey, 0%);
      }
    }

</style>