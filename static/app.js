const clockElement = document.querySelector('#clock');
const dateElement = document.querySelector('#date');
const timezoneElement = document.querySelector('#timezone');
const errorElement = document.querySelector('#error');

let selectedTimezone = timezoneElement.value;

function showError(message) {
  errorElement.textContent = message;
  errorElement.hidden = !message;
}

async function updateClock() {
  try {
    const response = await fetch(`/api/time?timezone=${encodeURIComponent(selectedTimezone)}`);
    if (!response.ok) throw new Error('Unable to load the current time.');
    const data = await response.json();
    const date = new Date(data.timestamp);
    clockElement.textContent = data.time;
    dateElement.textContent = new Intl.DateTimeFormat('en-US', {
      weekday: 'long', month: 'long', day: 'numeric', year: 'numeric', timeZone: selectedTimezone === 'Local Time' ? undefined : selectedTimezone,
    }).format(date);
    showError('');
  } catch (error) {
    showError(error.message);
  }
}

timezoneElement.addEventListener('change', () => { selectedTimezone = timezoneElement.value; updateClock(); });
updateClock();
setInterval(updateClock, 1000);
