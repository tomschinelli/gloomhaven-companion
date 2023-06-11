<script lang="ts">

    import IconButton from "./IconButton.svelte";
    import type {Character} from "$lib/Character";
    import {iconSelector} from "$lib/IconSelector";


    export let character: Character | undefined = undefined;
    let forceContextMenu = false;

    $: showContextMenu = !character || forceContextMenu

</script>

<div class="wrapper" on:click>
    {#if character}
        <img class="image"
             src={character.backImage}
             alt={character.name}
             on:click={()=>forceContextMenu=true}
        />
    {/if}
    {#if showContextMenu}
        <div class="overlay " class:animate={!character}>
            {#if !character}
                <IconButton icon="{iconSelector.add}"/>
            {:else}
                <IconButton icon="{iconSelector.delete}"/>
            {/if}
        </div>
    {/if}
</div>

<style lang="scss">
  .wrapper {
    height: 100%;
    position: relative;
    display: inline-block;

    img {
      width: 100%;
      background: blue;
      height: 100%;
      object-fit: cover;
      object-position: left;
    }
  }

  .overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;

    border: 2px dashed rgba(grey, 60%);
    background: rgba(black, 90%);

    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    > :global(*) {
      margin: 20px;
    }
  }

  .animate {
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0% {
      background: rgba(black, 0%);
    }

    70% {
      background: rgba(black, 50%);
      border: 2px dashed rgba(grey, 60%);
    }

    100% {
      background: rgba(black, 0%);
    }
  }

</style>