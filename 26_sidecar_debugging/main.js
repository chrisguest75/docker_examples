
  
function sleep(ms) {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}  

async function main() {
    let count = 0; 
    while (true) {
        let timeout = Math.random() * 1000;
        console.log("count - " + count + " " + timeout);
        await sleep(Number(timeout));
        count++;
    }
}

main()
