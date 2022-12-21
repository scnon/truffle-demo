
export class Key {
    id: string = '';
    owner: string = '';
    price: string = '';
}

export class Receipt {
    blockHash: string = '';
    blockNumber: number = 0;
    from: string = '';
    gasUsed: number = 0;
    status: boolean = false;
    to: string = '';
    transactionHash: string = '';
    transactionIndex: number = 0;
}

export class Tx {
    tx: string = '';
    logs: any[] = [];
    receipt: Receipt = new Receipt();
}
