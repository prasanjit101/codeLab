const editor_txtarea = document.getElementById("editor");
const preview_div = document.getElementById("preview");

editor_txtarea.addEventListener("keyup", function(){
    preview_div.innerHTML = marked(editor_txtarea.value);
});

function initialMarkdown()
{
    editor_txtarea.value = `
`;
    preview_div.innerHTML = marked(editor_txtarea.value);
}

window.onload = function(){
    initialMarkdown();
};
