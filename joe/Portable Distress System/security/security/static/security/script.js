function update(){
    if (document.getElementById("type").value=="protected"){
        document.getElementById("protected").disabled=false
    }
    else{
        document.getElementById("protected").disabled=true
    }
}
document.getElementById("protected").disabled=true
document.getElementById("protected").addEventListener("click",update)