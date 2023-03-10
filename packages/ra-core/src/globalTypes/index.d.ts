import { ReactNode } from 'react';

declare module 'react-query' {
    interface QueryClientProviderProps {
        children?: ReactNode;
    }
}
