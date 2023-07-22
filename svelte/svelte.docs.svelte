## Props

$$props references all props that are passed to a component, including ones that are not declared with export

$$restProps contains only the props which are not declared with export. It can be used to pass down other unknown attributes to an element in a component. It shares the same optimisation problems as $$props, and is likewise not recommended.


# { @debug }

The {@debug ...} tag offers an alternative to console.log(...). It logs the values of specific variables whenever they change, and pauses code execution if you have devtools open.

<script>
  let user = {
    firstname: 'Ada',
    lastname: 'Lovelace'
  };
</script>

{@debug user}

{@debug ...} accepts a comma-separated list of variable names (not arbitrary expressions).


# { @const }

{@const assignment}
The {@const ...} tag defines a local constant.

<script>
  export let boxes;
</script>

{#each boxes as box}
  {@const area = box.width * box.height}
  {box.width} * {box.height} = {area}
{/each}

{@const} is only allowed as direct child of {#if}, {:else if}, {:else}, {#each}, {:then}, {:catch}, <Component /> or <svelte:fragment />.


# Style Props

--style-props="anycssvalue"
You can also pass styles as props to components for the purposes of theming, using CSS custom properties.

Svelte's implementation is essentially syntactic sugar for adding a wrapper element. This example:

<Slider bind:value min={0} --rail-color="black" --track-color="rgb(0, 0, 255)" />
Desugars to this:

<div style="display: contents; --rail-color: black; --track-color: rgb(0, 0, 255)">
  <Slider bind:value min={0} max={100} />
</div>


