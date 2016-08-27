export const BenchConstants = {
  RECEIVE_BENCHES: "RECEIVE_BENCHES",
  REQUEST_BENCHES: "REQUEST_BENCHES"
};

export const requestBenches = () => ({
  type: BenchConstants.REQUEST_BENCHES
});

export const receiveBenches = (benches) => ({
  type: BenchConstants.RECEIVE_BENCHES,
  benches
});
