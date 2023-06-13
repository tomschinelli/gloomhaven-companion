<script lang="ts">

    import IconButton from "./IconButton.svelte";
    import type {Character} from "$lib/Character";
    import {iconSelector} from "$lib/IconSelector";
    import {createEventDispatcher} from "svelte";


    export let character: Character | undefined = undefined;
    let forceContextMenu = false;
    $: showContextMenu = !character || forceContextMenu


    // ---- events ---- //
    const dispatch = createEventDispatcher();
    const onDelete = () => dispatch("delete")
</script>

<div class="wrapper"
     class:enemy={character?.type === 'enemy'}
     class:hero={character?.type === 'hero'}
     on:click
>
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
                <IconButton on:click={onDelete} icon="{iconSelector.delete}"/>
            {/if}
        </div>
    {/if}
</div>

<style lang="scss">
  .wrapper {
    width: 100%;
    height: 100%;
    position: relative;
    display: inline-block;
    overflow: hidden;
    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: left;
    }
    &.enemy{
      img {

        position: absolute;
        left:0;
        width: 35px;
        height: 100%;
        //top: 50%;
        object-fit: cover;
        object-position: left;
      }
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