import Head from 'next/head'
import styles from '../styles/Home.module.css'
import React, { useRef, useState } from 'react'

import { Key, Tx } from "../model/key";
import KeyGame from "../model/keyGame";
import { useMetaMask } from "metamask-react";

const contract = require("@truffle/contract");
const KeyGameContract = contract(require("../build/contracts/KeyGame.json"));

export default function Home() {
  let current = useRef(new Key);
  const { status, connect, account, chainId, ethereum } = useMetaMask();
  let instance: KeyGame;

  async function getInstance() {
    KeyGameContract.setProvider(ethereum);
    instance = await KeyGameContract.deployed();
    // instance.methods.generateKey().call().then((balance: any) => {
    //   console.log(balance);
    // });
    instance.getHistory().then((result: Key[]) => {
      console.log(result);
    });
  }

  async function buyKey() {
    KeyGameContract.setProvider(ethereum);
    // instance.buyKey().sendTransaction({from: account, value: "10000000000000000" }).then((result: any) => {
    //   console.log(result);
    // });
    instance.buyKey({ from: account, gas: 100000 }).then((result: Tx) => {
      console.log(result.receipt.blockHash);
    });
  }

  async function getCurrent() {
    KeyGameContract.setProvider(ethereum);
    instance = await KeyGameContract.deployed();
    instance.getCurrent().then((result: Key) => {
      console.log(result);
      current.current = result;
    });
  }

  return (
    <>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={styles.main}>
        <button onClick={getCurrent}>Refresh</button>
        {
          current ? (
            <div>
              <p>Price: {current.current.price}</p>
              <p>Owner: {current.current.owner}</p>
              <p>Key: {current.current.id}</p>
              <button onClick={buyKey}>Buy</button>
            </div>
          ) : null
        }
      </main>
    </>
  )
}
