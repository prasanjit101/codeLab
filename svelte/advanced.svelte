
create progress component : [https://learn.svelte.dev/tutorial/tweens]
a circle that follows mouse pointer : [https://learn.svelte.dev/tutorial/springs]
transition : [https://learn.svelte.dev/tutorial/transition]
transition with parameter: [https://learn.svelte.dev/tutorial/adding-parameters-to-transitions]
transitions in and out : [https://learn.svelte.dev/tutorial/in-and-out]
transition events: [https://learn.svelte.dev/tutorial/transition-events]
Typewriter: [https://learn.svelte.dev/tutorial/key-blocks]
deferred transition: [https://learn.svelte.dev/tutorial/deferred-transitions]
Audio elements: [https://learn.svelte.dev/tutorial/media-elements]
Change dimensions or get realtime dimension: [https://learn.svelte.dev/tutorial/dimensions]
Change gradient color animation, example of This [https://learn.svelte.dev/tutorial/bind-this]
Bind components props ( keypad ) : [https://learn.svelte.dev/tutorial/component-bindings]
class binding (Flipped cards) : [https://learn.svelte.dev/tutorial/classes]
Component styles control from parent : [https://learn.svelte.dev/tutorial/component-styles]
slot props: [https://learn.svelte.dev/tutorial/slot-props]
Setcontext & getContext: [https://learn.svelte.dev/tutorial/context-api]
svelte:element [https://learn.svelte.dev/tutorial/svelte-element]
svelte:window [https://learn.svelte.dev/tutorial/svelte-window]
debug tag : [https://learn.svelte.dev/tutorial/debug]
Search Feature: [https://learn.svelte.dev/tutorial/slot-props]


 <!-- advanced binding -->
 <!-- Elements with a contenteditable attribute support textContent and innerHTML bindings: -->
 <div bind:innerHTML={html} contenteditable />

<!-- inline style -->
<button
	class="card"
	style:transform={flipped ? 'rotateY(0)' : ''}
	style:--bg-1="palegoldenrod"
	style:--bg-2="black"
	style:--bg-3="goldenrod"
	on:click={() => flipped = !flipped}
>

<button
	class="card {flipped ? 'flipped' : ''}"
	on:click={() => flipped = !flipped}
>
<!-- can be rewritten as -->
<button
	class="card"
	class:flipped={flipped}
	on:click={() => flipped = !flipped}
>

<!-- slots -->
<!-- card.svelte -->
<div class="card ">
	<slot/>
	<!-- slot with fallbacks -->
	<slot>
		<i>(company name)</i>
	</slot>
	<slot name="company"/>
</div>
<!-- app.svelte -->
<Card>
	<span>Patrick BATEMAN</span>
	<span slot="company">Vice President</span>
</Card>


<!-- 
The context API provides a mechanism for components to 'talk' to each other without passing around data and functions as props, or dispatching lots of events.
 -->
<script>
 	// in a parent component
	import { setContext } from 'svelte';
	import { writable } from 'svelte/store';

	setContext('my-context', {
		count: writable(0)
	});
	// in a child component
	import { getContext } from 'svelte';

	const { count } = getContext('my-context');

	$: console.log({ count });
</script>

<!-- a module can't import itself. Instead, we use <svelte:self> .Instead we use svelte:self-->
{#if file.files}
	<svelte:self {...file}/>
{:else}
	<File {...file}/>
{/if}


<!-- dynamic component -->
<script>
	const options = [
		{ color: 'red', component: RedThing },
		{ color: 'green', component: GreenThing },
		{ color: 'blue', component: BlueThing }
	];

	let selected = options[0];
</script>

<svelte:component this={selected.component} />

<!-- get scroll depth example -->
<script>
	let y = 0;
</script>

<svelte:window bind:scrollY={y} />

<span>depth: {y}px</span>

<!-- We can do that by declaring a <script context="module"> block. Code contained inside it will run once, when the module first evaluates, rather than when a component is instantiated.  -->

<!-- exports -->
<!-- AudioPlayer.svelte -->
<script context="module">
	let current;

	export function stopAll() {
		current?.pause();
	}
</script>
<!-- We can now import stopAll in App.svelte... -->

<!-- App.svelte -->
<script>
	import AudioPlayer, { stopAll } from './AudioPlayer.svelte';
</script>

