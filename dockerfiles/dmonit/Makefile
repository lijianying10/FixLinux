all:
	cp ../../dotfile/.tmux.conf .
	cp ../../dotfile/.vimrc .
	cp ../../dotfile/.bashrc .
	cp ../../script/freem .
	cp ../../script/xdev .
	cp ../../script/e .
	docker build -t dmonit:1.1 .
	rm .tmux.conf
	rm .vimrc
	rm .bashrc
	rm freem
	rm xdev
	rm e
clean:
	rm .tmux.conf
	rm .vimrc
	rm .bashrc
	rm freem
	rm xdev
	rm e
