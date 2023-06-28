<!-- 
RULES: 
> For updating arrays and objects state, add an assignment ( eg - numbers = [...numbers, numbers.length + 1];)
> It's a good practice to put the style section in the bottom
> Event modifiers in svelte: once, self, trusted, preventDefault
> To forward events :  eg - an on:message event directive without a value means 'forward all message events'.[https://learn.svelte.dev/tutorial/event-forwarding]
> Example to play audio [https://learn.svelte.dev/tutorial/dom-event-forwarding] & dom forwarding
> Logo animation example [https://learn.svelte.dev/tutorial/onmount]

-->

<script>
	export let answer = 'a mystery'; // default props
	import Nested from './Nested.svelte';//Component names are always capitalised

	let src = '/image.gif';
	let name = 'Rick Astley';
	let numbers = [];

	let string = `this string contains some <strong>HTML!!!</strong>`;
	let a = 0;
	let b = 3;

	let yes = false;
</script>

<style>
	p {
		color: goldenrod;
		font-family: 'Comic Sans MS', cursive;
		font-size: 2em;
	}
</style>

<img {src} alt="{name} dances." />
<p>This is a paragraph.</p>
<p>{@html string}</p>
<Nested/>

<!-- reactivity -->
<script>
	let count = 0;
	$: doubled = count * 2; // states which depend on other states
	function increment() {
		count += 1;
	}

	//run arbitrary statements reactively
	$: {
	console.log(`the count is ${count}`);
	console.log(`this will also be logged whenever count changes`);
	}
</script>

<!-- dom events -->
<button on:click={increment} on:pointermove={(e) => { m = { x: e.clientX, y: e.clientY }; }}>
	Clicked {count}
	{count === 1 ? 'time' : 'times'}
</button>
<p>{count} doubled is {doubled}</p>

<PackageInfo {...pkg} /> 
<!-- props will be destructured -->

<!-- if blocks -->
{#if count > 10}
	<p>{count} is greater than 10</p>
{:else if count < 5}
	<p>{count} is less than 5</p>
{:else}
	<p>{count} is between 5 and 10</p>
{/if}

<!-- each blocks -->
<!-- i is the index -->
{#each numbers as num , i}
	<p>{num}</p>
{/each}

<!-- keyed each blocks -->
<!-- (num) is the key. Better to have number or strings but can be object too -->
{#each numbers as num (num)}
	<p>{num}</p>
{/each}

<!-- async await -->
<!-- promiseVar is of type promise -->
{#await promiseVar}
	<p>...waiting</p>
{:then number}
	<p>The number is {number}</p>
{:catch error}
	<p style="color: red">{error.message}</p>
{/await}

<!-- dom event modifiers -->
<button on:click|once={() => alert('clicked')} disabled={yes}>
	Click me
</button>

<!-- event dispatcher -->
<!-- inner.svelte -->
<script>
	import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher();

	function sayHello() {
		dispatch('message', {
			text: 'Hello!'
		});
	}
</script>
<!-- app.svelte -->
<script>
	import Inner from './Inner.svelte';

	function handleMessage(event) {
		alert(event.detail.text);
	}
</script>

<Inner on:message={handleMessage} />

<!-- Binds the input data to the state name -->
<input bind:value={name} />

<label>
	<input type="number" bind:value={a} min="0" max="10" />
	<input type="range" bind:value={a} min="0" max="10" /> 
	<!-- slider input -->
	<input type="checkbox" checked={yes} />
</label>

<!-- until the binding is initialised, selected remains undefined, so we can't blindly reference e.g. selected.id in the template. -->
<select
	bind:value={selected}
	on:change={() => (answer = '')}
>
	{#each questions as question}
		<option value={question}>
			{question.text}
		</option>
	{/each}
</select>

<!-- To bind multiple radio items to a single value -->
<input
	type="radio"
	name="scoops"
	value={number}
	bind:group={scoops}
/>

<textarea bind:value={value}></textarea>

<script>
	import { onMount } from 'svelte';
	onMount(() => {
		// do something
	});

	import { tick } from 'svelte';
	await tick();// It returns a promise that resolves as soon as any pending state changes have been applied to the DOM (or immediately, if there are no pending state changes).
</script>

<!-- skipped : https://learn.svelte.dev/tutorial/update : beforeUpdate. afterUpdate -->

<!-- Stores (write in a js file, for demonstration used inside script tag-->
<script>
// writable stores
	import { writable } from 'svelte/store';
	export const count = writable(0);
	/*
	available functions -
	count.update((n) => n + 1);
	count.set(0)

	can be imported anywhere and used as a state
	*/
	//Any name beginning with $ is assumed to refer to a store value 
	//eg - $conunt
	
// To unsubscribe
	let count_value;

	const unsubscribe = count.subscribe(value => {
		count_value = value;
	});

	onDestroy(unsubscribe);

// readable stores
	//The first argument to readable is an initial value, which can be null or undefined if you don't have one yet. The second argument is a start function that takes a set callback and returns a stop function. The start function is called when the store gets its first subscriber; stop is called when the last subscriber unsubscribes.
	import { readable, derived } from 'svelte/store';

	export const time = readable(new Date(), function start(set) {
		const interval = setInterval(() => {
			set(new Date());
		}, 1000);

		return function stop() {
			clearInterval(interval);
		};
	});
//derived store
	export const elapsed = derived(
	time,
	($time) => Math.round(($time - start) / 1000)
	);
// custom stores
	function createCount() {
	const { subscribe, set, update } = writable(0);

	return {
		subscribe,
		increment: () => update((n) => n + 1),
		decrement: () => update((n) => n - 1),
		reset: () => set(0)
	};
	}

	export const customCount = createCount();
</script>

<!-- store bindings -->
<input bind:value={$name}>

<button on:click={() => $name += '!'}>
	Add exclamation mark!
</button>