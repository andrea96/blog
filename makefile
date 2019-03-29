build:
	hugo

server:
	hugo server

clean:
	rm -rf public/ resources/ 

deploy:
	hugo
	hugodeploy push
	git add --all
	git commit -m "Automatic commit"
	git push origin master	
