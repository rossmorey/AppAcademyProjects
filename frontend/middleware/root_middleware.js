import { applyMiddleware } from 'redux';
import BenchesMiddleware from './benches_middleware';

const RootMiddleware = applyMiddleware(
  BenchesMiddleware
);

export default RootMiddleware;
