**HTMX Cheat Sheet**

**1. Data Attributes**

- `hx-get`: Performs a GET request to the specified URL and updates the element with the response.
- `hx-post`: Performs a POST request to the specified URL and updates the element with the response.
- `hx-put`: Performs a PUT request to the specified URL and updates the element with the response.
- `hx-delete`: Performs a DELETE request to the specified URL and updates the element with the response.
- `hx-trigger`: Triggers the specified event when the element is clicked or interacted with.

**2. Targeting Elements**

- `hx-target`: Specifies the element(s) that should be updated with the response.
- `hx-swap`: Specifies how the element(s) should be updated (`innerHTML`, `outerHTML`, `beforeBegin`, `afterBegin`, `beforeEnd`, `afterEnd`).
- `hx-select`: Specifies a CSS selector to target specific elements within the response for updating.

**3. AJAX Request Parameters**

- `hx-params`: Specifies the data parameters to be sent with the request.
- `hx-swap-oob`: Specifies whether to swap the element(s) out-of-band (replacing before response) or in-band (replacing after response).
- `hx-headers`: Specifies custom HTTP headers to be sent with the request.
- `hx-indicator`: Specifies the element(s) to be shown as a progress indicator during the request.
- `hx-history-elt`: Specifies the element whose URL should be updated in the browser's history.

**4. Triggers and Events**

- `hx-trigger`: Specifies the event that triggers the request (`click`, `input`, `change`, etc.).
- `hx-poll`: Performs periodic polling by repeatedly executing the request at the specified interval.
- `hx-target`: Specifies the element(s) to update when the request is successful.
- `hx-error`: Specifies the element(s) to update when the request encounters an error.

**5. Additional Features**

- `hx-boost`: Enables turbo mode, which prefetches links and speeds up subsequent requests.
- `hx-confirm`: Displays a confirmation dialog before executing the request.
- `hx-ext`: Specifies the HTML extension used for server-side rendering (e.g., `php`, `py`, `rb`).

**Example Usage:**

```html
<button hx-get="/data" hx-target="#result">Load Data</button>
<div id="result"></div>
```

**6. Dynamic Updates**

- `hx-boost`: Enables turbo mode, which prefetches links and speeds up subsequent requests.
- `hx-sse`: Sets up a server-sent events (SSE) connection to receive real-time updates from the server.
- `hx-poll-interval`: Specifies the interval for polling requests when using `hx-poll`.

**7. Conditional Execution**

- `hx-include`: Specifies a condition that must be true for the request to be executed.
- `hx-exclude`: Specifies a condition that must be false for the request to be executed.

**8. Response Handling**

- `hx-swap-oob`: Specifies whether to swap the element(s) out-of-band (replacing before response) or in-band (replacing after response).
- `hx-encoding`: Specifies the encoding of the response (e.g., `utf-8`, `base64`).
- `hx-trigger`: Specifies the event that triggers the request (`click`, `input`, `change`, etc.).
- `hx-push-url`: Specifies whether to push the URL to the browser's history when the request is successful.
- `hx-push-url-interval`: Specifies the interval for pushing URL updates to the browser's history.

**9. CSS Transitions and Animations**

- `hx-transition`: Specifies the CSS transition to apply when updating the element(s).
- `hx-animation`: Specifies the CSS animation to apply when updating the element(s).

**10. Error Handling and Fallbacks**

- `hx-error`: Specifies the element(s) to update when the request encounters an error.
- `hx-target-attr`: Specifies an attribute to update on the target element(s) instead of the default `innerHTML`.
- `hx-fallback-url`: Specifies a URL to load if the request fails.

**11. JavaScript Integration**

- `hx-select`: Specifies a CSS selector to target specific elements within the response for updating.
- `hx-trigger`: Allows triggering custom JavaScript functions or events after a successful response.
- `hx-headers`: Enables sending custom HTTP headers along with the request.
- `hx-load`: Loads JavaScript files and executes them when the request is successful.

HTMX is a powerful library that simplifies the development of interactive web applications. It offers a wide range of features to enhance user experience and improve performance. Experimenting with these features will help you harness the full potential of HTMX in your projects.