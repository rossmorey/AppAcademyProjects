import { NotesConstants } from '../actions/note_actions.js';

const notesReducer = (state = [], action) => {
  switch (action.type) {
    case NotesConstants.KEY_PRESSED:
      return state.includes(action.key) ? state : [...state, action.key];
    case NotesConstants.KEY_RELEASED:
      let newState = state.filter(el => el !== action.key);
      return state.includes(action.key) ? newState : state;
    default:
      return state;
  }
};

export default notesReducer;
