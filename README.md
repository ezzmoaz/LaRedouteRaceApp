# Bee Race iOS App - Technical Test

## Overview
A real-time bee race tracking application built with Swift and SwiftUI that displays live position updates of racing bees through API integration.

## Requirements

### Time Constraint
- Maximum 4 hours development time
- It's acceptable if not fully completed

### Technology Stack
- Swift
- SwiftUI
- iOS Platform

## Features

### 1. Race Duration Fetch
**Endpoint:** `https://rtest.proxy.beeceptor.com/bees/race/duration`

**Response:**
```json
{
  "timeInSeconds": 26
}
```

**Functionality:**
- Fetch race duration on app start
- Display countdown timer

### 2. Live Position Tracking
**Endpoint:** `https://rtest.proxy.beeceptor.com/bees/race/status`

**Response:**
```json
{
  "beeList": [
    {
      "name": "BeeGees",
      "color": "#8d62a1"
    }
  ]
}
```

**Functionality:**
- Poll API during race duration
- Display bees in current race order
- Update UI in real-time
- Show bee name, color, and position medals

### 3. CAPTCHA Handling
**403 Response:**
```json
{
  "captchaUrl": "https://www.google.com/recaptcha/api2/demo"
}
```

**Functionality:**
- Display WebView when CAPTCHA is required
- Allow user to complete CAPTCHA
- Monitor for successful completion by checking:
  - `https://www.google.com/recaptcha/api2/userverify` returns 200
- Resume race tracking after CAPTCHA completion

**Test Endpoint:** `https://rtest.proxy.beeceptor.com/captchaTest`

### 4. Rate Limiting
**Constraint:** 30 calls per minute

**Error Response:**
```json
{
  "error": {
    "code": 429,
    "message": "You have exceeded the rate limit for this API endpoint."
  }
}
```

**Handling:**
- Implement appropriate polling intervals
- Handle rate limit errors gracefully

### 5. UI Design

**Screens:**
1. **Start Screen** - "Start Bee Race" button
2. **Race Screen**
   - Countdown timer at top
   - Scrollable list of bees with:
     - Colored bee icon
     - Position number (1st, 2nd, etc.)
     - Bee name
     - Medal icons (🥇🥈🥉) for top 3
3. **Winner Screen** - Display race winner
4. **CAPTCHA Screen** - WebView for reCAPTCHA
5. **Error Screen** - Handle service errors

**Assets:**
- Medals: https://flaticon.com/fr/chercher?word=medaille
- Bees: https://www.flaticon.com/fr/chercher?word=bee

## API Endpoints Summary

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/bees/race/duration` | GET | Get race duration |
| `/bees/race/status` | GET | Get current bee positions |
| `/captchaTest` | GET | Test CAPTCHA flow (optional) |

## Technical Challenges

1. **Real-time Updates** - Poll API efficiently without hitting rate limits
2. **State Management** - Track race state, timer, and bee positions
3. **WebView Integration** - Handle CAPTCHA flow seamlessly
4. **Error Handling** - Graceful degradation for network/API errors
5. **Rate Limiting** - Implement intelligent polling strategy

## Recommended Polling Strategy

- Calculate polling interval based on race duration
- Example: For 26 second race with 30 calls/minute limit:
  - Maximum: 30 calls / 60 seconds = 1 call every 2 seconds
  - Safe interval: 2.5-3 seconds to avoid rate limiting

## Submission Requirements

1. ✅ Complete Xcode project (zipped)
2. ✅ GitHub repository link (public preferred)
3. ✅ Demo video of compiled app (if working)
4. ✅ README with setup instructions

## Architecture Considerations

- **MVVM Pattern** - Separate business logic from views
- **Async/Await** - Modern Swift concurrency
- **Combine Framework** - Reactive state management
- **WebKit** - CAPTCHA WebView handling
- **URLSession** - Network requests

## Setup Instructions

1. Clone the repository
2. Open `BeeRace.xcodeproj` in Xcode
3. Select target device/simulator
4. Build and run (⌘R)

## Testing Strategy

1. Test normal race flow
2. Test CAPTCHA interruption
3. Test rate limiting handling
4. Test error scenarios
5. Test timer countdown accuracy

## Known Limitations

- API availability dependent on external service
- Network connectivity required
- CAPTCHA may require user interaction

## Future Enhancements

- Offline mode with mock data
- Race history
- Animation effects
- Sound effects
- Landscape orientation support

---

**Note:** This is a technical test project. Code quality and architecture decisions should demonstrate iOS development best practices within the 4-hour time constraint.
