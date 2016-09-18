import { combineReducers } from 'redux';
import notesReducer from './notes_reducer.js';
import tracksReducer from './tracks_reducer.js';
import isRecordingReducer from './is_recording_reducer.js';

const reducer = combineReducers({
  notes: notesReducer,
  isRecording: isRecordingReducer,
  tracks: tracksReducer
});

export default reducer;
