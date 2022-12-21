import { Key, Receipt, Tx } from './key';

export default interface KeyGame {
    getHistory(): Promise<Key[]>;
    getCurrent(): Promise<Key>;
    buyKey(opts: any): Promise<Tx>;
    getAward(): Promise<string>;
}