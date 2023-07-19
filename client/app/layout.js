"use client";
import "./globals.css";
import { ThirdwebProvider, ChainId } from "@thirdweb-dev/react";
import { StateContextProvider } from "../context";


export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
        <title>Real Estate</title>
      </head>
      <ThirdwebProvider activeChain={ChainId.Mumbai}>
        <StateContextProvider>
          <body>{children}</body>
        </StateContextProvider>
      </ThirdwebProvider>
    </html>
  );
}
