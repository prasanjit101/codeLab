# Installation

<script src="https://unpkg.com/htmx.org@1.9.2" integrity="sha384-L6OqL9pRWyyFU3+/bjdSri+iIphTN/bvYyM37tICVyOJkWZLpP2vGn6VUEXgzg6h" crossorigin="anonymous"></script>

## Common Key Events

They generally correspond to the ones in javascript except for... the enter button!

To use the enter button with HTMX, do the follow:

    ```
    <form action="" method="POST">
      <textarea cols="30" id="" name="command" rows="10">
      </textarea>
      <input
        name="" type="submit" value=""
        hx-target="#response-area"
        hx-trigger="keydown[shiftKey&&keyCode==13] from:body"
        hx-post=""
        hx-swap="innerHTML"
        hx-ext="debug"
        />
    </form>
    ```
Ta-Da! This will trigger on a "shift+enter" command.

## Attributes

These attributes can all be prefixed with data-hx-<method>

```
<div
    hx-<request>=""
    hx-trigger=""
    hx-target=""
    hx-swap="">
  Click Me
</div>
```

- hx-<request> where request can be get, post, put, patch, or delete: signifies the AJAX request that will be made when the element is activated.

- hx-trigger: this is how the ajax request on the element is triggered. Trigger types include:

- "click": mouse click
- "click[ctrlKey]": ctrlKey is an enclosed boolean javascript expression that, if true (e.g. ctrlKey is pressed while clicking with the mouse), will trigger.
- "click[someFuncion()]": will trigger if the mouse is clicked while the inside global function returns true
- "click[ctrlKey && shiftKey]": will trigger if the mouse is clicked while the ctrlKey and shiftKey is pressed at the same time.
(standard event modifiers are described below)
- "keydown[key=='Enter']" to trigger on an Enter key
hx-target: jQuery style selector ("#id", ".class", etc.) that will be affected, replaced, or filled with the response from the ajax request.

- hx-swap: what the ajax response will do on the hx-target. "outerHTML" will replace the element entirely while "innerHTML" will replace anything nested inside of it. can take a settle:<time> where time is a time value such as "1s" or "500ms" to put a delay on the swap.

- hx-confirm: shows a confirm dialog box before issuing the request

- hx-disable: will disable the attribute is active (e.g. exists) on the element

## Standard Event Modifiers for hx-trigger

These can be chained to have multiple (e.g. "keyup changed delay:1s")

- once: triggers only once (e.g. first click)
changed: only triggers if the element has changed -- only useful in practice on an input form

- delay:<time>: where time is a statement like "500ms" or "1s", will have a delay before the ajax request is made

- throttle:<time>: where time is a statement like "500ms" or "1s", if triggered again the element will not trigger until the end of that time delay.

- from:<css-selector>: will allow the ajax request to be triggered from another element. Can support some non-standard jquery selectors such as "document".

- target:<css-selector>: will allow a child attribute to that target element with the corresponding css-selector to trigger the ajax request.

- consume: if triggered, no other htmx requests, either direct or listening, will trigger on the parent element(s).

Exposes a javascript function called htmx.trigger().

## Request Payloads

- hx-encoding: changes the request encoding from "application/x-www-form-urlended" (default" to whatever this value is. Can be put on parent elements.

- hx-request: changes various aspects of the request, each of which needs to be double-quoted (e.g. '\"timeout\":100')

  * "timeout": in milliseconds
  * "credentials": whether to include credentials in the request
  * "noHeaders": wheter to send the request with no headers

- hx-headers: JSON-style name:expression values for the header to be included with the AJAX request (e.g. hx-headers='{"Bearer Token X": "abc"}').

- hx-include: include additional elements via a css-selector (e.g. "[name='email']" to get an input element with 'name="email"'.

- hx-vals: takes a JSON format of data (e.g. hx-vals='{"key":"val"}') that will be submitted with the ajax request.

- hx-push-url: whether to push the URL into the current browser -- can be "true" to append the hx-<request> value or a string representing the value to be pushed. Defaults to false.

## CSS Transitions

- 
<div id="parent"></div>
In the above section, htmx-settling class will be appended to the #parent tag. You could set CSS to create a transition. An example is below (though this example will look a bit ugly).

.htmx-settling {
  opacity: 0;
}


## Django CBV Snippets
To help with processing requests taht go back and forth

From templates

<form>
  {{ csrf_token }}
  {{ form.as_p }}
  <input type="submit">
</form>

Below is an example using CBVs in Django. When a POST request is made to "PostForm", it will perform validation against LoginForm and issue either a success_reponse_template (on success) or error_response_template on failure. On a GET request, it returns the page with the form embedded.

```
class LoginForm(forms.Form):
    username = forms.CharField(required=True)
    password = forms.CharField(
        max_length=32, widget=forms.PasswordInput, required=True, min_length=6
    )

class HtmxFormMixin(object):
def form_valid(self, form):
assert hasattr(self, "success_response_template") and hasattr(
self, "error_response_template"
), "No success_response_template and error_response_template configured"
if not form.is_valid():
return TemplateResponse(
request=self.request,
template=self.error_response_template,
context={"form_errors": form.errors},  # think this is correct...
using=None,
)
context = {**form.cleaned_data}
return TemplateResponse(
request=self.request,
template=self.success_response_template,
context=context,
using=None,  # template_engine
)
class PostForm(HtmxFormMixin, FormView):
```

## these are standard for FormView

template_name = "playground/login_form.html"
form_class = LoginForm
<span class="hljs-comment"># these are specific to the HtmxFormMixin</span>
<span class="hljs-attr">success_response_template</span> = <span class="hljs-string">"playground/login_reply.html"</span>
<span class="hljs-attr">error_response_template</span> = <span class="hljs-string">"playground/login_failure.html"</span>

<form hx-post="/post_form" hx-swap="outerHTML settle:1s" hx-target="this">
  {% csrf_token %}
  {{ form }}
  <input type="submit" value="Submit"/>
</form>