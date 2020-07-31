
// Kick off the start of the story!
    continueStory(true);

    // Main story processing function. Each time this is called it generates
    // all the next content up as far as the next set of choices.
    function continueStory(firstTime) {

        var paragraphIndex = 0;
        var delay = 0.0;
        
        // Don't over-scroll past new content
        var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY();

        // (Generate story text - loop through available content)
        while(story.canContinue) { //=while there is still content (in my case maybe something like "while there are still choices associated with my paragraphs")
            
            
        }
        
        //to start scrolling down on the next loop
        firstTime=false;
    }

//Replacement for the part in ink's main where you scroll down only when what you're viewing is not the first paragraph
var previousBottomEdge = localStorage.getItem("firstTime") ? 0 : contentBottomEdgeY();
localStorage.setItem("firstTime",true);

var delay = 200.0;

function showAfter(delay, el) {
        el.classList.add("hide");
        setTimeout(function() { el.classList.remove("hide"); }, delay);
    }

let paragraph=document.getElementById("message");
paragraph.innerText="Hello World";
showAfter(delay, paragraph);