let N=0
let n=0

echo "Figuras no usadas:"
for fig in $(ls {svg,img}/*); do
	let N=N+1
	grep $fig tex/*.tex &> /dev/null
	if [[ $? == 1 ]]; then
		let n=n+1
		echo "   $fig";
	fi;
done

echo " "
echo $n figuras no usadas de $N
