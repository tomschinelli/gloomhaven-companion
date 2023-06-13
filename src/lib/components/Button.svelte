
<button class:active={$$props.active} on:click>
    <slot />
</button>

<style>
    button{
        background: #310708;
        border: 2px solid #310708;
        color: white;
        padding: 5px 5px;

    }
    button.active{
        border: 2px solid  #560e10;
    }
</style>