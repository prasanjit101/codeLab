<!-- 
    INTRODUCTION:
At its core, SvelteKit's job boils down to three things:

Routing — figure out which route matches an incoming request
Loading — get the data needed by the route
Rendering - generate some HTML (on the server) or update the DOM (in the browser)

A good rule of thumb is 'put code close to where it's used'.
 -->

 ------------------------------

Routing: 
src/routes/about/+page.svelte -> /about
src/routes/+page.svelte -> /

------------------------------

Layout: 
src/routes/+layout.svelte -> layout
<nav>
	<a href="/">home</a>
	<a href="/about">about</a>
</nav>

<slot />

------------------------------

Route params:
src/routes/blog/[slug]/+page.svelte 
will create a route that matches /blog/one, /blog/two, /blog/three and so on.
NOTE: foo/[bar]x[baz] is a valid route, as long as a static character is between them

------------------------------

Loading:
Every page of your app can declare a load function in a +page.server.js file alongside the +page.svelte file. 
As the file name suggests, this module only ever runs on the server, including for client-side navigations.

src/routes/blog/+page.server.js
<script> //script tag used for purpose of syntax highlighting for js code in svelte file
    import { posts } from './data.js';
    import { error } from '@sveltejs/kit';

    export function load() {
        if(!summaries) {
            throw error(404);
        }
        return {
            summaries: posts.map((post) => ({
                slug: post.slug,
                title: post.title
            }))
        };
    }
</script>

We can access this data in src/routes/blog/+page.svelte via the data prop:
<script>
	export let data;
</script>

<ul>
	{#each data.summaries as { slug, title }}
		<li><a href="/blog/{slug}">{title}</a></li>
	{/each}
</ul>

------------------------------

Layout data:
Just as +layout.svelte files create UI for every child route, +layout.server.js files load data for every child route.

------------------------------

Setting Headers:
Inside a load function you have access to a setHeaders function, which can be used to set headers on the response.
Most commonly, you'd use it to customise caching behaviour with the Cache-Control response header

src/routes/+page.server.js
<script>
    export function load({ setHeaders }) {
        setHeaders({
            'Content-Type': 'text/plain'
        });
    }
</script>

------------------------------

Cookies:
The setHeaders function can't be used with the Set-Cookie header. Instead, you should use the cookies API.
can be used as:
src/routes/+page.server.js
<script>
    export function load({ cookies }) {
        const visited = cookies.get('visited');

        cookies.set('visited', 'true', { path: '/' });

        return {
            visited
        };
    }
</script>

------------------------------

The $lib alias:
Anything inside this directory can be accessed by any module in src via the $lib alias.
<script>
	import { message } from '$lib/message.js';// inside message js : export const message = 'hello from $lib/message';
</script>

------------------------------

Form handling:
src/routes/+page.svelte

<form method="POST" action="?/create">
    <label>
        add a todo:
        <input
            name="description"
            autocomplete="off"
        />
    </label>
</form>

server-side action to handle the POST request.
src/routes/+page.server.js
<script>
    import * as db from '$lib/server/database.js';
    import { fail } from '@sveltejs/kit';//fail function to return data from the action along with an appropriate HTTP status code
    
    export function load({ cookies }) {
        // ...
    }

    export const actions = {
	create: async ({ cookies, request }) => {
		const data = await request.formData();
        try {
			db.createTodo(cookies.get('userid'), data.get('description'));
		} catch (error) {
			return fail(422, {//provide an indication of what went wrong
				description: data.get('description'),
				error: error.message
			});
		}
	},

	delete: async ({ cookies, request }) => {
		const data = await request.formData();
		db.deleteTodo(cookies.get('userid'), data.get('id'));
	}
};
//Default actions cannot coexist with named actions.`
//The action attribute can be any URL — if the action was defined on another page, you might have something like /todos?/create.
//Since the action is on this page, we can omit the pathname altogether, hence the leading ? character.
</script>

We have to create a form for each todo, complete with a hidden <input> that uniquely identifies it:
src/routes/+page.svelte
<ul class="todos">
	{#each data.todos as todo (todo.id)}
		<li>
			<form method="POST" action="?/delete">
				<input type="hidden" name="id" value={todo.id} />
				<span>{todo.description}</span>
				<button aria-label="Mark as complete" />
			</form>
		</li>
	{/each}
</ul>

form prop, which is only ever populated after a form submission:
<script>
	export let data;
	export let form;
</script>

<h1>todos</h1>

{#if form?.error}
	<p class="error">{form.error}</p>
{/if}

<form method="POST" action="?/create">
	<label>
		add a todo:
		<input
			name="description"
			value={form?.description ?? ''}
			autocomplete="off"
			required
		/>
	</label>
</form>

------------------------------

use:enhance - Updating the page rather than reloading it:
[https://learn.svelte.dev/tutorial/progressive-enhancement]

use:enhance will emulate the browser-native behaviour except for the full-page reloads. It will:

update the form prop
invalidate all data on a successful response, causing load functions to re-run
navigate to the new page on a redirect response
render the nearest error page if an error occurs

src/routes/+page.svelte
<script>
	import { enhance } from '$app/forms';

	export let data;
	export let form;
</script>

src/routes/+page.svelte
<form method="POST" action="?/create" use:enhance></form>


Using use:enhance to show loading message : [https://learn.svelte.dev/tutorial/customizing-use-enhance]

------------------------------

API routes:

We can also create API routes by adding a +server.js file that exports functions corresponding to HTTP methods: GET, PUT, POST, PATCH and DELETE.

src/routes/roll/+server.js

<script>
    import { json } from '@sveltejs/kit';

    export function GET() {
        const number = Math.floor(Math.random() * 6) + 1;

        /* return new Response(number, {
            headers: {
                'Content-Type': 'application/json'
            }
        }); */

        return json(number);
    }

    export async function POST({ request, cookies }) {
        // do something
    }

    export async function PUT({ params/* path parameter */, request, cookies }) {
        // do something
        return new Response(null, { status: 204 });
    }
</script>

------------------------------

Page Stores:

SvelteKit makes three readonly stores available via the $app/stores module — page, navigating and updating. 
The one you'll use most often is page, which provides information about the current page:

url — the URL of the current page
params — the current page's parameters
route — an object with an id property representing the current route
status — the HTTP status code of the current page
error — the error object of the current page, if any
data — the data for the current page, combining the return values of all load functions
form — the data returned from a form action


<script>
	import { page } from '$app/stores';
</script>

<a href="/" aria-current={$page.url.pathname === '/'}>
    home
</a>

The navigating store represents the current navigation.
the value of navigation will become an object with the following properties:

from and to — objects with params, route and url properties
type — the type of navigation, e.g. link, popstate or goto

It can be used to show a loading indicator for long-running navigations.
<script>
	import { page, navigating } from '$app/stores';
</script>

{#if $navigating}
navigating to {$navigating.to.url.pathname}
{/if}

------------------------------

Errors:

Expected Error:
src/routes/expected/+page.server.js
<script>
import { error } from '@sveltejs/kit';

export function load() {
	throw error(420, 'Enhance your calm');
}
</script>

Unexpected Error:
src/routes/unexpected/+page.server.js
<script>
    export function load() {
	    throw new Error('Kaboom!');
    }
</script>

-------------------------------

Error Page:

src/routes/+error.svelte
<script>
	import { page } from '$app/stores';
	import { emojis } from './emojis.js';
</script>

<h1>{$page.status} {$page.error.message}</h1>
<span style="font-size: 10em">
	{emojis[$page.status] ?? emojis[500]}
</span>

Notice that the +error.svelte component is rendered inside the root +layout.svelte. We can create more granular +error.svelte boundaries:

src/routes/expected/+error.svelte
<h1>this error was expected</h1>

This component will be rendered for /expected, while the root src/routes/+error.svelte page will be rendered for any other errors that occur.

------------------------------

Fallback Error Page:

When things go really wrong

You can customise the fallback error page. Create a src/error.html file:

src/error.html
<h1>Game over</h1>
<p>Code %sveltekit.status%</p>
<p>%sveltekit.error.message%</p>
This file can include the following:

%sveltekit.status% — the HTTP status code
%sveltekit.error.message% — the error message

-------------------------------

Redirects:

src/routes/a/+page.server.js
<script>
    import { redirect } from '@sveltejs/kit';

    export function load() {
        throw redirect(307, '/b');
    }
</script>

Navigating to /a will now take us straight to /b.

You can throw redirect(...) inside load functions, form actions, API routes and the handle hook, which we'll discuss in a later chapter.

The most common status codes you'll use:

303 — for form actions, following a successful submission
307 — for temporary redirects
308 — for permanent redirects


