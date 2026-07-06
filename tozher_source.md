# Tozher – Social Goal Tracking Platform

## Project Overview

**Tozher** is a hybrid social networking and personal goal‑tracking application.  
Users create **goals** broken down into **achievements**, earn **points** by completing achievements, share progress via **posts**, and interact through **likes**, **comments** and **supports**.  

The **home feed** displays posts from:
- users that the current user **supports** (follows), **and**
- users who share at least one **interest** with the current user.

An **admin** can broadcast notifications. The system also sends automatic reminders for unfinished achievements and notifies users about interactions on their posts.

---

## Core Entities & Relationships

### 1. User
| Field       | Type      | Description                                     |
|-------------|-----------|-------------------------------------------------|
| `id`        | UUID      | Primary key                                     |
| `fullName`  | string    |                                                 |
| `username`  | string    | Unique                                          |
| `email`     | string    | Unique, used for login & password reset         |
| `password`  | string    | Hashed                                          |
| `age`       | integer   |                                                 |
| `gender`    | string    |                                                 |
| `points`    | integer   | Gained each time an achievement is marked `isDone` |
| `role`      | enum      | `admin` or `user`                               |

**Relationships**  
- `has many` goals  
- `has many` interests (many‑to‑many)  
- `has many` posts  
- `has many` comments  
- `has many` notifications  
- `supports many users` (follow relation) → used for home feed  
- `receives support from` other users (followers)

### 2. Goal
| Field          | Type      | Description                                                          |
|----------------|-----------|----------------------------------------------------------------------|
| `id`           | UUID      |                                                                      |
| `userId`       | UUID      | FK to User                                                           |
| `name`         | string    |                                                                      |
| `description`  | text      |                                                                      |
| `date`         | date      | Deadline to get the goal done                                        |
| `reminderDate` | date      | **Validation** – must be ≤ midpoint between `created_at` and `date`  |
| `status`       | enum      | `public` (visible on profile) or `private` (hidden)                  |

**Relationships**  
- `has many` achievements

### 3. Achievement
| Field           | Type    | Description                                           |
|-----------------|---------|-------------------------------------------------------|
| `id`            | UUID    |                                                       |
| `goalId`        | UUID    | FK to Goal                                            |
| `name`          | string  |                                                       |
| `description`   | text    |                                                       |
| `isDone`        | boolean | When flipped from `false` → `true` → user gains points|

> **Creation rule** – When creating a goal, the user also enters all achievements (they are created together).

### 4. Interest
| Field    | Type   | Description                       |
|----------|--------|-----------------------------------|
| `id`     | UUID   |                                   |211111111111111
| `name`   | string | e.g., "Fitness", "Coding", "Art"  |
| `icon`   | string | Icon identifier / URL             |

Many‑to‑many with **User**.

### 5. Post
| Field            | Type          | Description                                                                 |
|------------------|---------------|-----------------------------------------------------------------------------|
| `id`             | UUID          |                                                                             |
| `userId`         | UUID          | Author                                                                      |
| `title`          | string        |                                                                             |
| `photos`         | list(string)  | URLs or paths to uploaded images                                            |
| `mentionedGoals` | list(UUID)    | IDs of goals **owned by the author** – clicking navigates to that goal inside author’s profile |
| `likesCount`     | integer       |                                                                             |
| `commentsCount`  | integer       | Denormalised (can be calculated from Comment entity)                        |
| `sharesCount`    | integer       |                                                                             |
| `supportsCount`  | integer       | Same behaviour as likes (separate counter for “support” reaction)           |

**Relationships**  
- `has many` comments  
- `has many` likes (join table `PostLike`)  
- `has many` post‑supports (join table `PostSupport`)

### 6. Comment
| Field     | Type   | Description          |
|-----------|--------|----------------------|
| `id`      | UUID   |                      |
| `postId`  | UUID   | FK to Post           |
| `userId`  | UUID   | Author               |
| `title`   | string | Comment content/text |

### 7. Notification
| Field        | Type      | Description                                                                 |
|--------------|-----------|-----------------------------------------------------------------------------|
| `id`         | UUID      |                                                                             |
| `userId`     | UUID      | Recipient                                                                   |
| `type`       | enum      | `admin_broadcast`, `reminder_unfinished_achievement`, `post_comment`, `post_like`, `post_support` |
| `message`    | string    |                                                                             |
| `isRead`     | boolean   |                                                                             |
| `createdAt`  | timestamp |                                                                             |
| `relatedId`  | UUID      | Optional – ID of the related post, achievement, or comment                  |

---

## Authentication & Roles

- **Public routes** – Login, Register, Forgot password (send email with verification code), Reset password.
- **Role `admin`** – Can send broadcast notifications to all users.
- **Role `user`** – Default after registration.

**Auth flow**  
1. Register → login → access protected pages.  
2. Forgot password → request email reset → enter verification code → set new password.

---

## Functional Requirements

### User & Profile
- Each user has a **profile page** displaying:
  - Full name, username, age, gender, interests, total points.
  - List of public goals (with achievements & progress).
  - Posts authored by the user.
- User can **update** profile information and interests.

### Goals & Achievements

| Action                     | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| Create goal                | Provide name, description, deadline (`date`), reminder date, public/private. **Add one or more achievements** (each with name, description). |
| Edit goal                  | Change name, description, dates, visibility.                                |
| Toggle goal visibility     | Button on each goal to switch between `public` / `private`.                 |
| Mark achievement as done   | Toggle `isDone` → instantly adds points to user’s total (one‑time reward).  |
| View goals page            | Shows **all** goals of the current user, each with its achievements and done/not done status. Button “+ Add goal” to create new goal. |

**Reminder date validation**  
- Let `created_at` = goal creation date, `deadline` = goal.date.  
- Rule: `reminderDate ≤ created_at + (deadline - created_at)/2`  
  (reminder must be scheduled in the first half of the goal’s lifespan).

### Posts & Interactions

- **Create post** – Title, multiple photos, mention existing goals (only from the author’s own goals).  
- **Home feed** – Shows posts from:
  - users that the current user **supports** (follows)
  - users who share **at least one interest** with the current user  
  → Ordered by most recent.
- **Post actions** – Like, Comment, Support (separate count, same behaviour as like), Share.  
- **Mentioned goals** – When clicked, navigate to the **goal page inside the author’s profile**.

### Search Page

- Search allows searching by **posts** (title/content) **or** **users** (username, full name).  
- Results shown in two tabs or a segmented control.

### Support (Follow) System

- User A can **support** User B (one‑way relation).  
- The **home feed** includes posts from supported users **and** users with same interests.  
- A separate “Support” count exists on **posts** (post‑level reaction) – different from user‑to‑user support.

---

## Notification System

| Trigger                                                      | Recipient          | Notification Type                 |
|--------------------------------------------------------------|--------------------|-----------------------------------|
| Admin sends broadcast                                       | All users          | `admin_broadcast`                 |
| Reminder date reached and at least one achievement is **not done** | Goal owner        | `reminder_unfinished_achievement` |
| Someone comments on my post                                 | Post author        | `post_comment`                    |
| Someone likes my post                                       | Post author        | `post_like`                       |
| Someone supports my post                                    | Post author        | `post_support`                    |

> Notifications appear in a notification centre (e.g., bell icon). Users can mark them as read.

---

## Page Structure & Navigation

### Auth Pages (Unauthenticated)
- Login  
- Register  
- Request password reset (enter email)  
- Verification code entry  
- Reset password  

### Authenticated Layout (Home Layout)

- **App bar** – Leading `+` button → navigates to **Add Post** screen.  
- **Bottom navigation** – 4 buttons:

| Icon/Label | Page Name | Content                                                                 |
|------------|-----------|-------------------------------------------------------------------------|
| 🏠 Home     | Home page | Feed of posts from supported users + users with same interests.         |
| 🔍 Search   | Search page| Search posts or users.                                                 |
| 🎯 Goals    | Goals page | View/manage own goals & achievements. Button to add goal. Toggle public/private per goal. |
| 👤 Profile  | Profile page| View own profile details, points, public goals, posts. Edit profile.   |

### Additional Screens (reachable from bottom nav or inside)
- **Add Post** (from app bar)  
- **Goal detail** – from goals page or from a mentioned goal in a post.  
- **Other user’s profile** – when searching or clicking on a post author.

---

## UI/UX Colour Palette

All interfaces must follow these hex codes:

| Colour | Hex       | Usage suggestion                     |
|--------|-----------|--------------------------------------|
| 1      | `#F4F9F9` | Backgrounds, cards, light areas      |
| 2      | `#F1D1D0` | Secondary surfaces, hover states     |
| 3      | `#F875AA` | Primary buttons, active icons, links |
| 4      | `#FBACCC` | Accents, highlights, badges          |

**Example application**  
- App bar background: `#F875AA` with white icons  
- Bottom navigation active tint: `#F875AA`  
- Body background: `#F4F9F9`  
- Buttons: `#F875AA`, text white  
- Goal progress bar: `#FBACCC`

---

## Business Rules & Validations

| Rule                                | Constraint                                                                 |
|-------------------------------------|----------------------------------------------------------------------------|
| Goal reminder date                  | Must be ≤ midpoint between goal creation date and deadline (`goal.date`).  |
| Points awarding                     | Awarded **once** per achievement when `isDone` becomes `true`. No points if toggled back to `false`. |
| Public / private goal               | Private goals are never shown on the user’s profile to others, but appear in the user’s own goals page. |
| Mentioned goals in a post           | Only goals belonging to the **post author** can be mentioned.              |
| User support (follow)               | A user cannot support themselves.                                          |
| Post support                        | Any user can support a post (same behaviour as like).                      |

---

## Database Considerations (summary)

- Use **UUID** for primary keys.  
- Store `points` on `User` table – update when an achievement’s `isDone` toggles to true.  
- Many‑to‑many tables:  
  - `user_interests` (user_id, interest_id)  
  - `user_supports` (follower_id, following_id) – follower supports following.  
  - `post_likes` (user_id, post_id)  
  - `post_supports` (user_id, post_id)  
- For performance, `likesCount`, `supportsCount`, `commentsCount` can be denormalised columns on `posts` and updated via triggers or application logic.

---

## Example Flows

**Create a goal with achievements**  
1. Navigate to Goals page → tap “+ Add goal”  
2. Fill name, description, deadline, reminder date, public/private  
3. Add achievement rows (name + description) – at least one required  
4. Submit → Goal and its achievements are persisted.

**Gain points**  
1. In Goals page, user checks `isDone` on an achievement.  
2. Backend checks if it was previously false → if true, adds points (e.g., +10) to user’s `points`.  
3. Profile page reflects new total.

**Admin broadcast**  
1. Admin logs in → sees an extra admin panel.  
2. Composes a message → sends → system inserts a `Notification` record for every user (type=`admin_broadcast`).

**Home feed composition**  
1. User A supports User B and shares interest “Fitness” with User C.  
2. User A’s home feed shows posts from both User B and User C.  
3. Posts from supported users appear alongside posts from interest‑matched users, merged by recency.

---

## Non‑functional (optional)

- Responsive design (mobile‑first)  
- Real‑time or pull‑to‑refresh for new posts/notifications  
- Image upload support (photos in posts)  
- Push notifications (recommended for reminders + interactions)

---

**End of Tozher Specification**  
Any AI receiving this document should be able to understand the domain, relationships, pages, colours, and business logic required to build the Tozher application.