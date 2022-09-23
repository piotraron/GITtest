const nftsCount = 10000;
let s_minNR = 1;
let m_minNR = 1;
let b_minNR = 1;

function raffle() {
    //implement if current mint = max dont run
    if (s_minNR < nftsCount) {
        //roll for 100s
        //100 rolls
        console.log("\n\nRoll for SMALL prize \n\n")
        for (let i = 0; i < 5; i++) {
            let s_maxNR = s_minNR + 99;
            let s_winner_A = getRndInteger(s_minNR, s_maxNR);
            let s_winner_B = getRndInteger(s_minNR, s_maxNR);
            console.log(`Winner of a draw between numbers ${s_minNR} and ${s_maxNR} is ${s_winner_A} -- 0.5 eth`);
            console.log(`Winner of a draw between numbers ${s_minNR} and ${s_maxNR} is ${s_winner_B} -- 0.5 eth`);
            s_minNR = s_minNR + 100;
        }

        //1000 rolls
        console.log("\n\nRoll for MID prize \n\n")
        let m_maxNR = m_minNR + 499;
        let m_winner = getRndInteger(m_minNR, m_maxNR);
        console.log(`Winner for a draw between numbers ${m_minNR} and ${m_maxNR} is ${m_winner} -- 2 eth`);
        m_minNR = m_minNR + 500;


        //2000 rolls
        let b_maxNR = b_minNR + 1999;
        // console.log(`m_maxnr ${m_maxNR}  --- b_min ${b_maxNR}`);
        if (m_maxNR >= b_maxNR) {
            console.log("\n\nRoll for BIG prize \n\n\n");
            let b_winner = getRndInteger(b_minNR, b_maxNR);
            console.log(`Winner for a draw between numbers ${b_minNR} and ${b_maxNR} is ${b_winner} -- 10 eth`);
            console.log("--------------------------------------------------------------------------")
            b_minNR = b_minNR + 2000;
        }
    }

}

function all() {
    for (let i = 0; i < 10; i++) { raffle() }
}

function getRndInteger(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}



let runNR = 1;
function random() {
    console.log(`NFT number:  ${runNR}\n\n`);
    runNR = runNR + 1;

    const fvMIN = 1;
    const fvMAX = 10;
    let firstValue = getRndInteger(fvMIN, fvMAX);
    console.log(`\nFirst random value is \n${firstValue}\n`);

}