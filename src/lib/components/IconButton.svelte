<script lang="ts">
    import Fa from 'svelte-fa/src/fa.svelte'
    import {faAdd} from "@fortawesome/free-solid-svg-icons";
    import type{IconDefinition} from "@fortawesome/free-solid-svg-icons";

    export let icon: IconDefinition = faAdd;
    export let size = "1.5x"

</script>
<button class="icon icon-fill"
        on:click
        on:mouseover
        on:mouseenter
        on:mouseleave
>
    <Fa icon={icon} size="{size}"/>

</button>

<style lang="scss">
  $icon-size: 50px;
  $border-radius: 0.5; //15% = 0.15, 50% = 0.50 etc.

  $background: #2d2c3e;
  $background-b: #2d2c3e;

  // Icon Colors
  $green: #16A085;
  $red: #C82647;
  $green-l: #8CC63F;
  $orange: #EB9532;
  $purple: #7E3661;

  // Text
  $white: #FFFFFF;

  .icon {
    background: transparent;
    border: none;
  }

  .icon {
    cursor: pointer;
    position: relative;
    display: inline-block;
    width: $icon-size;
    height: $icon-size;
    line-height: $icon-size;
    //background: red;
    text-align: center;
    border-radius: $icon-size*$border-radius;
    overflow: hidden;

    &::before, &::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      width: 100%;
      transition: all 0.25s ease;
      border-radius: $icon-size*$border-radius;
    }

    :global(svg) {

      position: relative;
      //color: $white;
      //background: blue;
      color: #363642;

      margin-top: 13px;
      //margin-top: calc( $icon-size/4 );
      //margin-left: calc( $icon-size/4 ); // wtf
      transition: all 0.25s ease;
    }


  }


  .icon-fill {
    &::before {
      transition-duration: 0.5s;
      //box-shadow: inset 0 0 0 1px $white;
      box-shadow: inset 0 0 0 $icon-size $white;

    }

    //&:hover::before {
    //  box-shadow: inset 0 0 0 $icon-size $white;
    //}

  }


</style>
