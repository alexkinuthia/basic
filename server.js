var http = require('http');
var fs = require('fs');


//404
function send404(response) {
	response.writeHead('404',{"content-type" : "text:plain"});
	response.write('Error 404: page not found');
	response.end();
}


function onRequest(request,response) {
	if (request.method == 'GET' && request.url == '/') {
		response.writeHead(200,{"content-type" : "text/html"});
		fs.createReadStream("./index.html").pipe(response);


	}else{
		send404(response);
	}
}
http.createServer(onRequest).listen(8080);
console.log('Server Running');