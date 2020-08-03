<%-- 
    Document   : Winterfair
    Created on : Jul 25, 2020, 7:08:17 PM
    Author     : Trisha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>The Winter Fair</title>
        <link href="styles/style.css" rel="stylesheet" type="text/css"/>
        
    </head>
    <body>
        <h1>Winter Fair story</h1>
        
        <div class="outerContainer">
            <div id="story" class="container">
                <div class="header">
                    <h1>The Winter Fair</h1>
                    <h2 class="byline"></h2>
                </div>
                <div id="original"></div>
                <div id="text">
                    ${paragraph}<br/>
                    ${number}
                </div>
                
                <script> var options = new Array;</script>
                <c:forEach items="${choices}" var="choice">
                    <script>
                        var choice={number:"${choice.target}", text:"${choice.option}"};
                        options.push(choice);
                    </script>
                </c:forEach>
                
                <div id="choices"></div>
            </div>
        </div>
        
        
        <%--<script src="js/notmain.js" type="text/javascript"></script>--%>
        <script>
            //Store the existing part of the story in localstorage
            if (localStorage.getItem("existingtext")!==null){
                var original=document.getElementById("original");
                original.innerText=localStorage.getItem("existingtext");
            }
            var existingText = document.getElementById("original").innerText+document.getElementById("text").innerText;
            localStorage.setItem("existingtext", existingText);
            
            //Create choices
            let storyChoices = document.getElementById("choices");
            
            for (let option of options) {
                var choiceParagraphElement = document.createElement('p');
                choiceParagraphElement.classList.add("choice");
                choiceParagraphElement.innerHTML="<a href=story.htm?load=loadNext&option="+option.number+">" + option.text +"</a>";
                storyChoices.appendChild(choiceParagraphElement);
            }
            
            
            
            
            
            
            
            
            /* TAKE AWAY OPTIONS AFTER CHOICE HAS BEEN MADE
            var choiceAnchorEl = document.querySelectorAll("a");
            for (var i=0; i<choiceAnchorEl.length; i++){
                choiceAnchorEl[i].addEventListener("click", function(event) {

                    // Don't follow <a> link
                    //event.preventDefault();

                    // Remove all existing choices
                    var choiceParagraphs = document.getElementById("choices");

                    // As long as div has a child node, remove it
                    while (choiceParagraphs.hasChildNodes()) {  
                      choiceParagraphs.removeChild(choiceParagraphs.firstChild);
                    }
                    
                    

                });
            }*/
        </script>
    </body>
</html>
