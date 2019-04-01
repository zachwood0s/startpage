
categories = [
    {
        name: "kstate",
        color: "base14",
        links: [
            {
                name: "canvas",
                link: "https://k-state.instructure.com"
            },
            {
                name: "ksis",
                link: "https://ksis.k-state.edu"
            },
            {
                name: "tophat",
                link: "https://app.tophat.com/e/909821/lecture/"
            },
            {
                name: "webmail",
                link: "https://outlook.office365.com/owa/?realm=ksu.edu"
            },
        ]
    },
    {
        name: "google",
        color: "base08",
        links:[
            {
                name: "gmail",
                link: "https://mail.google.com"
            },
            {
                name: "docs",
                link: "https://docs.google.com"
            },
            {
                name: "drive",
                link: "https://drive.google.com"
            },
        ]
    },
    {
        name: "reddit",
        color: "base10",
        links: [
            {
                name: "apexlegends",
                link: "https://reddit.com/r/apexlegends"
            },
            {
                name: "programming",
                link: "https://reddit.com/r/programming"
            },
            {
                name: "all",
                link: "https://reddit.com/r/all"
            },
        ]
    }
]

function load(){
    var linksElm = document.getElementById("links");
    for(var i = 0; i<categories.length; i++){
        var category = categories[i];
        console.log(categories);
        var categoryElm = document.createElement("div");
        categoryElm.classList.add("category");
        categoryElm.classList.add("color-"+category.color);
        var title = document.createElement("span");
        title.classList.add("title");
        title.innerHTML = category.name;
        categoryElm.appendChild(title);

        for(var j = 0; j < category.links.length; j++){
            var link = category.links[j];
            categoryElm.appendChild(createItem(link.link, link.name));
        }
        linksElm.appendChild(categoryElm);
    }
}

function createItem(link, title){
    var linkElm = document.createElement("a");
    linkElm.href = link;
    linkElm.target = "blank";
    var span = document.createElement("span");
    span.classList.add("item");
    span.innerHTML = title;
    linkElm.appendChild(span);
    return linkElm;
}


window.onload = load;

