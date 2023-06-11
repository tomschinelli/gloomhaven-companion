<script lang="ts">

    import type {Character} from "$lib/Character";

    export let character: Character

</script>
<div class="character-card" on:click>
    <img class="image" src={character.backImage} alt={character.name}>
</div>

<style>
    .image {
        width: 100%;
    }

    .character-card {
        display: inline-block;
        vertical-align: bottom;
        line-height: 0;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

</style>