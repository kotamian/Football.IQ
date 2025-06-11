
I will create a single HTML file for a football blog website inspired by Goal.com with a calm, superb, and interesting design. The features will include:
- Latest news and historical information about football (combined in one feed or sections)
- Responsive layout with a modern, clean, and breathable UI optimized for mobile, tablet, desktop, and large desktop breakpoints
- A 3-column layout for desktop and large desktop, collapsing to fewer columns on smaller devices
- Navigation header with logo and essential menu items
- A collapsible sidebar on tablet and above for category filtering
- Articles feed with summarized articles including titles, images, date, and snippet
- A reading panel or modal for a detailed article view (to simulate a reading experience)
- Bookmarking for saved articles (using localStorage for persistence)
- Night mode toggle for distraction-free reading
- Search function to filter articles by keyword
- Accessibility features and Google Material icons usage
- Using placeholder images from placehold.co with descriptive alt text
- Smooth transitions and modern styling following modern web design standards specified

I will start by drafting the entire HTML with inline CSS and JavaScript to provide these features with sample articles (both historical and latest) as static content.

No external backend integration or RSS fetching will be added unless requested later, as onsite content will simulate the experience.

Next step: create the file football-blog.html with the above features and structure.


`football-blog.html`
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Football Blog | Latest & Historic News</title>
<style>
  /* Reset & base */
  *, *::before, *::after {
    box-sizing: border-box;
  }
  html {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
      Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    font-size: 16px;
    scroll-behavior: smooth;
  }
  body {
    margin: 0;
    background-color: var(--bg);
    color: var(--text);
    line-height: 1.6;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    transition: background-color 0.3s ease, color 0.3s ease;
  }

  /* Theme variables */
  :root {
    --color-primary-start: #4e54c8;
    --color-primary-end: #8f94fb;
    --color-accent: #06b6d4;
    --color-bg-light: #f9faff;
    --color-text-light: #1f2937;
    --color-bg-dark: #121212;
    --color-text-dark: #e0e0e0;
    --shadow-light: rgba(0, 0, 0, 0.1);
    --shadow-dark: rgba(255, 255, 255, 0.1);
    --radius: 12px;
    --spacing: 24px;
    --text-large: 1.125rem;
    --header-height: 60px;
  }
  body.light {
    --bg: var(--color-bg-light);
    --text: var(--color-text-light);
    --shadow: var(--shadow-light);
  }
  body.dark {
    --bg: var(--color-bg-dark);
    --text: var(--color-text-dark);
    --shadow: var(--shadow-dark);
  }

  /* Container */
  .container {
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
    padding: 0 var(--spacing);
  }

  /* Header */
  header {
    position: sticky;
    top: 0;
    background: linear-gradient(135deg, var(--color-primary-start), var(--color-primary-end));
    color: white;
    height: var(--header-height);
    display: flex;
    align-items: center;
    padding: 0 var(--spacing);
    z-index: 101;
    box-shadow: 0 2px 8px var(--shadow);
  }
  .logo {
    font-weight: 900;
    font-size: 1.5rem;
    letter-spacing: 2px;
    background: linear-gradient(135deg, #e0eafc, #cfdef3);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    user-select: none;
  }
  nav {
    margin-left: auto;
    display: flex;
    gap: 24px;
    align-items: center;
  }
  nav a {
    color: white;
    text-decoration: none;
    font-weight: 600;
    font-size: var(--text-large);
    padding: 8px 12px;
    border-radius: var(--radius);
    transition: background-color 0.3s ease;
  }
  nav a:hover,
  nav a:focus-visible {
    background: rgba(255 255 255 / 0.2);
    outline-offset: 2px;
  }
  button.icon-btn {
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    border-radius: 50%;
    padding: 8px;
    transition: background-color 0.3s ease;
  }
  button.icon-btn:hover,
  button.icon-btn:focus-visible {
    background: rgba(255 255 255 / 0.2);
    outline-offset: 2px;
  }

  /* Layout & grid */
  main {
    flex: 1;
    display: grid;
    grid-template-columns: 1fr;
    gap: var(--spacing);
    margin-top: var(--spacing);
    margin-bottom: var(--spacing);
    padding: 0 var(--spacing);
  }
  /* Sidebar */
  aside {
    background: var(--bg);
    padding: var(--spacing);
    border-radius: var(--radius);
    box-shadow: 0 2px 10px var(--shadow);
    position: sticky;
    top: calc(var(--header-height) + var(--spacing));
    height: fit-content;
  }
  aside h2 {
    font-size: 1.25rem;
    margin-bottom: 16px;
    font-weight: 700;
  }
  aside nav > ul {
    list-style: none;
    padding-left: 0;
    display: flex;
    flex-direction: column;
    gap: 12px;
  }
  aside nav a {
    text-decoration: none;
    color: var(--text);
    font-weight: 600;
    padding: 8px 12px;
    border-radius: var(--radius);
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background-color 0.25s ease;
  }
  aside nav a:hover,
  aside nav a[aria-current="true"],
  aside nav a:focus-visible {
    background: linear-gradient(135deg, var(--color-primary-start), var(--color-primary-end));
    color: white;
    outline-offset: 2px;
  }
  aside nav a .material-icons {
    font
