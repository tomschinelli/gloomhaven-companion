<script lang="ts">

    import type {Character} from "$lib/Character";

    export let character: Character

</script>
<div class={"character-card "+character.type} on:click>
    <img src={character.backImage} alt={character.name}>


</div>

<style lang="scss">
  img {
    width: 100%;
  }

  .character-card {
    display: inline-block;
    vertical-align: bottom;
    line-height: 0;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  }

  .enemy {

    img {
      display: inline-block;
      height: 28px;
      width:100%;

      object-fit: cover;
      object-position: top;
    }
  }

</style>