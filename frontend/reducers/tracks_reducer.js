import {TracksConstants} from '../actions/tracks_actions.js';
import { merge } from 'lodash/merge';

let curTrackId = 0;

const tracksReducer = (state = {}, action) => {
  switch (action.type) {
    case TracksConstants.START_RECORDING:
      curTrackId++;
      let newTrack = {
        id: curTrackId,
        name: `Track ${curTrackId}`,
        roll: [],
        timeStart: action.timeNow
      };
      return merge({}, state, {curTrackId: newTrack});
    case TracksConstants.STOP_RECORDING:
      let currTrack = merge({}, state[curTrackId]);
      currTrack.roll.push({
        notes: [],
        timeSlice: action.timeNow - state[curTrackId].timeStart
      });
      return merge({}, state, {curTrackId: currTrack});
    case TracksConstants.ADD_NOTES:
      let currTrack2 = merge({}, state[curTrackId]);
      currTrack2.roll.push({
        notes: action.notes,
        timeSlice: action.timeNow - state[curTrackId].timeStart
      });
      return merge({}, state, {curTrackId: currTrack2});
    default:
      return state;
  }
};

export default tracksReducer;
