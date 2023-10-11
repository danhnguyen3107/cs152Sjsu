var net = require('net');
var eol = require('os').EOL;

var srvr = net.createServer();
var clientList = [];

srvr.on('connection', function(client) {
  client.name = client.remoteAddress + ':' + client.remotePort;
  client.write('Welcome, ' + client.name + eol);
  clientList.push(client);

  client.on('data', function(data) {
    console.log(data+"")
    console.log("\\list")
    process(("" + data).substring( 0, data.indexOf(eol)), client);
  });
});

function process(data, client){
  
  
  if (data === "") return;
  
  var input = data.split(' ')
  
  if(input[0] === "\\list") listCom(client)
  else if(input[0] === "\\rename") renameCom(input, client)
  else if(input[0] === "\\private") privateCom(input, client, data)
  else broadcast(data, client)
}


function broadcast(data, client) {
  for (var i in clientList) {
    if (client !== clientList[i]) {
      clientList[i].write(client.name + " says " + data + eol);
    }
  }
}
function listCom(client){
  

    client.write("List of Peoples: ");

    for (let i of clientList)
      if (i !== client) client.write(i.name + " ");

    client.write(eol);
    
}

function renameCom(input, client){
    if(input.length > 1){
      client.name = input[1];
      client.write("New name: " + input[1] + eol);
    }else client.write("Error: No Name Provided" + eol)
}
function privateCom(input, client, data){
  if (input.length > 2) {
    for (let i of clientList)
      if (i.name == input[1])
        i.write(client.name + " DMed you: " + data.substring(data.indexOf(input[2])) + eol);
  }else client.write("Error: No Message");
}


srvr.listen(9000);

