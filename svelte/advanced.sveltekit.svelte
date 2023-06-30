hooks — ways to intercept and override the framework's default behaviour.
eg - handle, which lives in src/hooks.server.js. It receives an event object along with a resolve function, and returns a Response

hooks.server.js
<script>
    export async function handle({ event, resolve }) {
        return await resolve(event);
    }
</script>

For pages (as opposed to API routes), you can modify the generated HTML with transformPageChunk:

src/hooks.server.js
<script>
    export async function handle({ event, resolve }) {
        if (event.url.pathname === '/ping') {
            return new Response('pong');
        }
        return await resolve(event, {
            transformPageChunk: ({ html }) => html.replace(
                '<body',
                '<body style="color: hotpink"'
            )
        });
    }
</script>

event object has the following properties:

    cookies — the cookies API
    fetch — the standard Fetch API, with additional powers
    getClientAddress() — a function to get the client's IP address
    isDataRequest — true if the browser is requesting data for a page during client-side navigation, false if a page/route is being requested directly
    locals — a place to put arbitrary data
    params — the route parameters
    request — the Request object
    route — an object with an id property representing the route that was matched
    setHeaders(...) — a function for setting HTTP headers on the response
    url — a URL object representing the current request

A useful pattern is to add some data to event.locals in handle so that it can be read in subsequent load functions:

Note: It is the same object — an instance of a RequestEvent — that is passed into API routes in 
    +server.js files, form actions in +page.server.js files, and load functions in +page.server.js and +layout.server.js


----------------------------------------

Fetch:

The event object has a fetch method.

1. it can be used to make credentialed requests on the server, as it inherits the cookie and authorization headers from the incoming request
2. it can make relative requests on the server (ordinarily, fetch requires a URL with an origin when used in a server context)
internal requests (e.g. for +server.js routes) go directly to the handler function when running on the server, without the overhead of an HTTP call
3. Its behaviour can be modified with the handleFetch hook

For example, we could respond to requests for src/routes/a/+server.js with responses from src/routes/b/+server.js instead:

src/hooks.server.js
<script>
export async function handleFetch({ event, request, fetch }) {
	const url = new URL(request.url);
	if (url.pathname === '/a') {
		return await fetch('/b');
	}

	return await fetch(request);
}
</script>


----------------------------------------

HandleError :
The handleError hook lets you intercept unexpected errors and trigger some behaviour, 
    like pinging a Slack channel or sending data to an error logging service.

[https://learn.svelte.dev/tutorial/handleerror]

src/hooks.server.js
<script>
export function handleError({ event, error }) {
	console.error(error.stack);

	return {
		message: 'everything is fine',
		code: 'JEREMYBEARIMY'
	};
}
</script>

src/routes/+error.svelte
<script>
	import { page } from '$app/stores';
</script>

<h1>{$page.status}</h1>
<p>{$page.error.message}</p>
<p>error code: {$page.error.code}</p>


----------------------------------------

ssr:

some components can't be rendered on the server, perhaps because they expect to be able to access browser globals like window immediately.
If you can, you should change those components so that they can render on the server, but if you can't then you can disable SSR:

src/routes/+page.server.js
export const ssr = false;

NOTE: Setting ssr to false inside your root +layout.server.js effectively turns your entire app into a single-page app (SPA)

----------------------------------------

csr:

As with ssr, you can disable client-side rendering altogether:

src/routes/+page.server.js
export const csr = false;
This means that no JavaScript is served to the client, but it also means that your components are no longer interactive.

----------------------------------------

prerender:

Prerendering means generating HTML for a page once, at build time, rather than dynamically for each request.
prerendered content can only be updated by building and deploying a new version of the application.
To prerender a page, set prerender to true:

src/routes/+page.server.js
export const prerender = true;

NOTE: Setting prerender to true inside your root +layout.server.js effectively turns SvelteKit into a static site generator (SSG).

----------------------------------------

trailingSlash:

In short, being loosey-goosey about trailing slashes is a bad idea. By default, SvelteKit strips trailing slashes, meaning that a request for /foo/ will result in a redirect to /foo.

If you instead want to ensure that a trailing slash is always present, you can specify the trailingSlash option accordingly:

src/routes/always/+page.server.js
<script>
    export const trailingSlash = 'always';
</script>

To accommodate both cases (this is not recommended!), use 'ignore':

src/routes/ignore/+page.server.js
<script>
    export const trailingSlash = 'ignore';
</script>

NOTE: The default value is 'never'.

Whether or not trailing slashes are applied affects prerendering. A URL like /always/ will be saved to disk as always/index.html whereas a URL like /never will be saved as never.html.


----------------------------------------

Preloading:

When an <a> element has a data-sveltekit-preload-data attribute, SvelteKit will begin the navigation as soon as the user hovers over the link (on desktop) or taps it (on mobile). Try adding it to the first link:

src/routes/+layout.svelte
<nav>
    <a href="/slow-a" data-sveltekit-preload-data>slow-a</a>
    <a href="/slow-b">slow-b</a>
</nav>

data-sveltekit-preload-code allows you to preload the JavaScript needed by a given route without eagerly loading its data.

You can also initiate preloading programmatically with preloadCode and preloadData imported from $app/navigation:

<script>
    import { preloadCode, preloadData } from '$app/navigation';

    // preload the code and data needed to navigate to /foo
    preloadData('/foo');

    // preload the code needed to navigate to /bar, but not the data
    preloadCode('/bar');
</script>


----------------------------------------

Reloading the page:

Ordinarily, SvelteKit will navigate between pages without refreshing the page.
To refresh the page between navigation
data-sveltekit-reload attribute on an individual link, or any element that contains links:

src/routes/+layout.svelte
<nav data-sveltekit-reload>
	<a href="/">home</a>
</nav>

----------------------------------------

Path params:

src/routes/[[lang]]/+page.server.js
<script>
const greetings = {
	en: 'hello!',
	de: 'hallo!',
	fr: 'bonjour!'
};

export function load({ params }) {
	return {
		greeting: greetings[params.lang ?? 'en']
	};
}
</script>


----------------------------------------

Rest Parameters:

To match an unknown number of path segments, use a [...rest] parameter,

NOTE: Rest parameters do not need to go at the end — a route like /items/[...path]/edit or /items/[...path].json is totally valid.

Example: for page not found

if you needed a custom 404 page for pages inside /categories/..., you could add these files:

src/routes/
├ categories/
│ ├ animal/
│ ├ mineral/
│ ├ vegetable/
│ ├ [...catchall]/
│ │ ├ +error.svelte
│ │ └ +page.server.js
Inside the +page.server.js file, throw error(404) inside load.


----------------------------------------

Param Matches:

First, create a new file called src/params/hex.js and export a match function from it:

src/params/hex.js
export function match(value) {
	return /^[0-9a-f]{6}$/.test(value);
}
Then, to use the new matcher, rename src/routes/colors/[color] to src/routes/colors/[color=hex].


----------------------------------------


Routing Groups:

Sometimes it's useful to use layouts without affecting the route — for example, you might need your /app and /account routes to be behind authentication, 
while your /about page is open to the world. We can do this with a route group, which is a directory in parentheses.

Create an (authed) group by renaming account to (authed)/account then renaming app to (authed)/app.

Now we can control access to these routes by creating src/routes/(authed)/+layout.server.js

[https://learn.svelte.dev/tutorial/route-groups] Example of Authentication groups


----------------------------------------


Breaking out of layouts:

Occasionally, it's useful to break out of the current layout hierarchy. We can do that by adding the @ sign followed by the name of the parent segment to 'reset' to — 
    for example +page@b.svelte would put /a/b/c inside src/routes/a/b/+layout.svelte, while +page@a.svelte would put it inside src/routes/a/+layout.svelte.

NOTE: The root layout applies to every page of your app, you cannot break out of it.


----------------------------------------


Universal Load functions -

Sometimes it doesn't make sense to load data from the server when doing a client-side navigation. For example:

- You're loading data from an external API
- You want to use in-memory data if it's available
- You want to delay navigation until an image has been preloaded, to avoid pop-in
- You need to return something from load that can't be serialized (SvelteKit uses devalue to turn server data into JSON), such as a component or a store

To turn the server load functions into universal load functions, rename each +page.server.js file to +page.js. Now, the functions will run on the server during server-side rendering, but will also run in the browser when the app hydrates or the user performs a client-side navigation.

[https://learn.svelte.dev/tutorial/universal-load-functions]


----------------------------------------


Using both Load functions -

src/routes/+page.js
<script>
export async function load({ data }) {
	const module = data.cool
		? await import('./CoolComponent.svelte')
		: await import('./BoringComponent.svelte');

	return {
		component: module.default,
		message: data.message
	};
}
</script>


----------------------------------------


Using Parent data-

await parent()
For the load functions to access data from their parents.
Demo [https://learn.svelte.dev/tutorial/await-parent]


----------------------------------------

Invalidation:

World Clock Demo [https://learn.svelte.dev/tutorial/invalidation]

When the user navigates from one page to another, SvelteKit calls your load functions, but only if it thinks something has changed.
In this example, navigating between timezones causes the load function in src/routes/[...timezone]/+page.js to re-run because params.timezone is invalid. But the load function in src/routes/+layout.js does not re-run, because as far as SvelteKit is concerned it wasn't invalidated by the navigation.

----------------------------------------

Custom Dependencies:

Calling fetch(url) inside a load function registers url as a dependency. 
Sometimes it's not appropriate to use fetch, in which case you can specify a dependency manually with the depends(url) function

src/routes/+layout.js
<script>
export async function load({ depends }) {
	depends('data:now');

	return {
		now: Date.now()
	};
}
</script>

----------------------------------------

Invalidate All:

invalidateAll(). This will indiscriminately re-run all load functions for the current page, regardless of what they depend on.

import { invalidateAll } from '$app/navigation';



----------------------------------------

Env Variables:

Environment variables in process.env are also available via $env/static/private.
import { PASSPHRASE } from '$env/static/private';

It can only be imported into server modules:

- +page.server.js
- +layout.server.js
- +server.js
- any modules ending with .server.js
- any modules inside src/lib/server
In turn, these modules can only be imported by other server modules.

The static in $env/static/private indicates that these values are known at build time, and can be statically replaced.

----------------------------------------

Dyamic env variables:

env variables whose value are known at runtime

import { env } from '$env/dynamic/private';

----------------------------------------

Public Envs:

import {
    PUBLIC_THEME_BACKGROUND,
    PUBLIC_THEME_FOREGROUND
} from '$env/static/public';

---------------------------------------

Public dynamic envs:

import { env } from '$env/dynamic/public';