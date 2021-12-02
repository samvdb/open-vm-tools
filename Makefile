run:
	docker build -t openvm .
	docker run -ti openvm /bin/bash