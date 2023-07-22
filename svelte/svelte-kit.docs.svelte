# FETCH

NOTE:
A special version of fetch is available in load functions, server hooks and API routes for invoking endpoints directly during server-side rendering, without making an HTTP call, while preserving credentials. (To make credentialled fetches in server-side code outside load, you must explicitly pass cookie and/or authorization headers.) It also allows you to make relative requests, whereas server-side fetch normally requires a fully qualified URL.

# requests

An instance of Request is accessible in hooks and server routes as event.request

# URL

URLs are represented by the URL interface, which includes useful properties like origin and pathname (and, in the browser, hash). This interface shows up in various places — event.url in hooks and server routes, $page.url in pages,

# URL searchParams

const foo = url.searchParams.get('foo');

# UUID

const uuid = crypto.randomUUID();

# page.ts
Often, a page will need to load some data before it can be rendered. For this, we add a +page.ts module that exports a load function.

src/routes/blog/[slug]/+page.ts

import type { PageLoad } from './$types';
export const load = (({ params }) => {
    if (params.slug === 'hello-world') {
        return {
            title: 'Hello world!',
        };
    }
    throw error(404, 'Not found');
}) satisfies PageLoad;

# page.server.ts

If your load function can only run on the server — for example, if it needs to fetch data from a database or you need to access private environment variables like API keys — then you can rename +page.ts to +page.server.ts and change the PageLoad type to PageServerLoad.

import type { PageServerLoad } from './$types';



# $page.data

In some cases, we might need the opposite — a parent layout might need to access page data or data from a child layout. For example, the root layout might want to access a title property returned from a load function in +page.ts or +page.server.ts. This can be done with $page.data:

src/routes/+layout.svelte
<script>
    import { page } from '$app/stores';
</script>

<svelte:head>
    <title>{$page.data.title}</title>
</svelte:head>

# Using parent data
Occasionally it's useful for a load function to access data from a parent load function, which can be done with await parent():

# Hierarchy

layout.server.ts -> layout.ts -> layout.svelte -> page.server.ts -> page.ts -> page.svelte

# To check if dev server is running

import { browser, dev, building, version } from '$app/environment';
const dev: boolean;
const browser: boolean; // true if the app is running in the browser.

const building: boolean;
const version: string;


# Goto

Returns a Promise that resolves when SvelteKit navigates (or fails to navigate, in which case the promise rejects) to the specified url. For external URLs, use window.location = url instead of calling goto(url).


const preloadData: (href: string) => Promise<void>;


import { assets, base } from '$app/paths';
Example usage: <a href="{base}/your-page">Link</a>


# Sequence hooks

import { sequence } from '@sveltejs/kit/hooks';

A helper function for sequencing multiple handle calls in a middleware-like manner. The behavior for the handle options is as follows:

transformPageChunk is applied in reverse order and merged
preload is applied in forward order, the first option "wins" and no preload options after it are called
filterSerializedResponseHeaders behaves the same as preload

import { sequence } from '@sveltejs/kit/hooks';

async function first({ event, resolve }) {
    console.log('first pre-processing');
    const result = await resolve(event, {
        transformPageChunk: ({ html }) => {
            // transforms are applied in reverse order
            console.log('first transform');
            return html;
        },
        preload: () => {
            // this one wins as it's the first defined in the chain
            console.log('first preload');
        }
    });
    console.log('first post-processing');
    return result;
}

async function second({ event, resolve }) {
    console.log('second pre-processing');
    const result = await resolve(event, {
        transformPageChunk: ({ html }) => {
            console.log('second transform');
            return html;
        },
        preload: () => {
            console.log('second preload');
        },
        filterSerializedResponseHeaders: () => {
            // this one wins as it's the first defined in the chain
           console.log('second filterSerializedResponseHeaders');
        }
    });
    console.log('second post-processing');
    return result;
}

export const handle = sequence(first, second);

--------------------------------------
The example above would print:

first pre-processing
first preload
second pre-processing
second filterSerializedResponseHeaders
second transform
first transform
second post-processing
first post-processing



# Hooks

Code in these modules will run when the application starts up, making them useful for initializing database clients and so on.

## handle
This function runs every time the SvelteKit server receives a request 

import type { Handle } from '@sveltejs/kit';
export const handle = (async ({ event, resolve }) => {
    <!-- code here -->
}) satisfies Handle;

## handleFetch

For example, your load function might make a request to a public URL like https://api.yourapp.com when the user performs a client-side navigation to the respective page, but during SSR it might make sense to hit the API directly (bypassing whatever proxies and load balancers sit between it and the public internet).

src/hooks.server.ts
import type { HandleFetch } from '@sveltejs/kit';

export const handleFetch = (async ({ request, fetch }) => {
    if (request.url.startsWith('https://api.yourapp.com/')) {
        // clone the original request, but change the URL
        request = new Request(
            request.url.replace('https://api.yourapp.com/', 'http://localhost:9999/'),
            request
        );
    }

    return fetch(request);
}) satisfies HandleFetch;


# Optional parameters

[[lang]]/home - optional
[lang]/home - required

optional route parameter cannot follow a rest parameter ([...rest]/[[optional]])



# Matcher

src/params/integer.ts
import type { ParamMatcher } from '@sveltejs/kit';

export const match = ((param) => {
    return /^\d+$/.test(param);
}) satisfies ParamMatcher;



# URL paths encoding with special character

https://kit.svelte.dev/docs/advanced-routing#encoding


# Avoid shared state on the serverpermalink
Browsers are stateful — state is stored in memory as the user interacts with the application. Servers, on the other hand, are stateless — the content of the response is determined entirely by the content of the request.


# Using stores with context

src/routes/+layout.svelte
<script lang="ts">
    import { setContext } from 'svelte';
    import { writable } from 'svelte/store';

    import type { LayoutData } from './$types';

    export let data: LayoutData;
    // Create a store and update it when necessary...
    const user = writable();
    $: user.set(data.user);
    // ...and add it to the context for child components to access
    setContext('user', user);
</script>
src/routes/user/+page.svelte
<script>
    import { getContext } from 'svelte';
    // Retrieve user store from context
    const user = getContext('user');
</script>

<p>Welcome {$user.name}</p>



# to completely destroy and remount a component on navigation, you can use this pattern:

{#key $page.url.pathname}
    <BlogPost title={data.title} content={data.title} />
{/key}


# Snapshot

Ephemeral DOM state — like scroll positions on sidebars, the content of <input> elements and so on — is discarded when you navigate from one page to another.

For example, if the user fills out a form but clicks a link before submitting, then hits the browser's back button, the values they filled in will be lost. In cases where it's valuable to preserve that input, you can take a snapshot of DOM state, which can then be restored if the user navigates back.

+page.svelte
<script lang="ts">
    import type { Snapshot } from './$types';

    let comment = '';

    export const snapshot: Snapshot = {
        capture: () => comment,
        restore: (value) => comment = value
    };
</script>

<form method="POST">
    <label for="comment">Comment</label>
    <textarea id="comment" bind:value={comment} />
    <button>Post comment</button>
</form>


