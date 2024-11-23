'use client';

import { useContext } from 'react';
import { StateContext, DispatchContext } from '@/app/store';
import { requestAccounts } from '@/components/wallet';

const ConnectButton = () => {
  const { web3Provider } = useContext(StateContext);
  const dispatch = useContext(DispatchContext);
  const connectHandler = () => {
    requestAccounts(dispatch, web3Provider);
  };

  if (!web3Provider) {
    return (
      <a 
        className="w-full relative inline-flex items-center justify-center p-0.5 mb-2 me-2 overflow-hidden font-bold text-gray-900 rounded-lg group bg-gradient-to-br from-red-200 via-red-300 to-red-700 group-hover:from-red-200 group-hover:via-red-300 group-hover:to-red-700 dark:text-white dark:hover:text-gray-900 focus:ring-4 focus:outline-none focus:ring-red-100 dark:focus:ring-red-400"
        href="https://chromewebstore.google.com/detail/pelagus/nhccebmfjcbhghphpclcfdkkekheegop"
        target="_blank"
      >
        <span className="w-full relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
          Install Pelagus Wallet
        </span>
      </a>
    );
  } else {
    return (
        <button 
          className="w-full relative inline-flex items-center justify-center p-0.5 mb-2 me-2 overflow-hidden font-bold text-gray-900 rounded-lg group bg-gradient-to-br from-red-200 via-red-300 to-red-700 group-hover:from-red-200 group-hover:via-red-300 group-hover:to-red-700 dark:text-white dark:hover:text-gray-900 focus:ring-4 focus:outline-none focus:ring-red-100 dark:focus:ring-red-400"
          onClick={connectHandler}>
            <span className="w-full relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
              Connect Wallet
            </span>
        </button>
    );
  }
};

export default ConnectButton;