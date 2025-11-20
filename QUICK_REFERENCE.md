# TechVision Landing Page - Quick Reference

## 📁 File Structure

```
landing-page/
├── index.html                 # Main landing page (DO NOT DELETE)
├── README.md                  # Full documentation
├── DEPLOYMENT.html            # Deployment guide (open in browser)
├── QUICK_REFERENCE.md         # This file
└── assets/
    ├── css/
    │   ├── style.css         # Main stylesheet (all styling)
    │   └── customization.css # Customization examples (reference)
    ├── js/
    │   └── main.js           # JavaScript functionality
    └── images/               # Add your images here
```

## 🚀 Quick Commands

### Start Local Server
```bash
# Python 3
python -m http.server 8000

# Node.js
npx http-server

# PHP
php -S localhost:8000
```

Then open: `http://localhost:8000`

## 🎨 Quick Customizations

### Change Brand Colors
Edit `:root` variables in `assets/css/style.css`:

```css
:root {
    --primary-color: #0066cc;      /* Main color */
    --accent-cyan: #00d4ff;        /* Accent color */
    --accent-purple: #9333ea;      /* Secondary accent */
    --accent-orange: #ff6b35;      /* Tertiary accent */
    --bg-primary: #ffffff;         /* Background */
    --text-primary: #1a202c;       /* Text color */
}
```

### Update Company Name
1. Search for "TechVision" in `index.html`
2. Replace with your company name
3. Update logo text

### Change Contact Information
Find these sections in `index.html` and update:
- Phone: "+1 (555) 123-4567"
- Email: "info@techvision.com"
- Location: "123 Tech Street, San Francisco, CA"

### Update Services Section
Edit the service cards in the `<section class="services">` section with your services.

### Modify Hero Section
- Change headline in `<h1 class="hero-title">`
- Update subtitle in `<p class="hero-subtitle">`
- Modify CTA buttons text

## 🔧 Common Tasks

### Add New Service Card
```html
<div class="service-card" style="--delay: 0.6s;">
    <div class="service-icon">
        <i class="fas fa-icon-name"></i>  <!-- Change icon -->
    </div>
    <h3>Service Name</h3>
    <p>Service description goes here.</p>
    <a href="#" class="service-link">Learn More →</a>
</div>
```

### Add New Portfolio Item
```html
<div class="portfolio-item" style="--delay: 0.3s;">
    <div class="portfolio-image">
        <img src="assets/images/project.jpg" alt="Project Name">
    </div>
    <div class="portfolio-content">
        <h3>Project Name</h3>
        <p>Project description</p>
        <div class="portfolio-tags">
            <span>Technology</span>
            <span>Framework</span>
        </div>
    </div>
</div>
```

### Add Social Media Link
In footer section, add to `.social-links`:
```html
<a href="https://yourprofile" title="Platform">
    <i class="fab fa-platform-name"></i>
</a>
```

## 📱 Responsive Breakpoints

- **Desktop**: 1024px and above
- **Tablet**: 768px to 1023px
- **Mobile**: 480px to 767px
- **Small Mobile**: Below 480px

## 🎯 Key Features

| Feature | Location | Status |
|---------|----------|--------|
| Mobile Menu | Navigation bar | ✓ Working |
| Smooth Scrolling | All internal links | ✓ Working |
| Form Validation | Contact section | ✓ Working |
| Animations | Throughout page | ✓ Enabled |
| Dark Footer | Bottom section | ✓ Dark theme |
| Hero Background | Hero section | ✓ Animated blobs |

## 🔗 Important Links

- **Font Awesome Icons**: https://fontawesome.com/icons
- **Google Fonts**: https://fonts.google.com
- **Color Picker**: https://htmlcolorcodes.com
- **Gradient Generator**: https://www.cssgradient.io

## 💡 Tips & Tricks

1. **Icon Library**: Use Font Awesome for icons - massive collection free icons
2. **Color Scheme**: Try [Coolors](https://coolors.co) to generate color palettes
3. **Testing**: Use Chrome DevTools (F12) to test responsiveness
4. **Performance**: Compress images before uploading
5. **Backup**: Keep a backup of original files before customizing

## 🐛 Common Issues & Solutions

### Issue: Images not showing
- Check file path is correct
- Ensure image format is supported
- Verify image permissions
- Try opening directly in browser

### Issue: Styles not applied
- Hard refresh browser (Ctrl+Shift+R)
- Check CSS file path
- Verify no CSS errors in DevTools
- Check CSS file wasn't moved

### Issue: JavaScript not working
- Ensure JS file is in correct location
- Check browser console for errors
- Verify JavaScript is enabled
- Hard refresh page

### Issue: Mobile menu not opening
- Check JS file exists
- Look for console errors
- Test on different browser
- Verify hamburger button HTML is present

## 📚 Documentation

- **Full Documentation**: See `README.md`
- **Deployment Guide**: Open `DEPLOYMENT.html` in browser
- **This Guide**: You're reading it!

## 🚢 Deployment Steps

1. Customize content and branding
2. Test locally thoroughly
3. Optimize images
4. Update SEO meta tags
5. Choose hosting platform
6. Deploy files
7. Test on live server
8. Set up analytics

## 💻 Recommended Tools

- **Code Editor**: VS Code, Sublime Text, Atom
- **Browser**: Chrome, Firefox (for development)
- **Image Editor**: GIMP, Photoshop, Figma
- **FTP Client**: FileZilla (for traditional hosting)
- **Version Control**: Git + GitHub

## 🎓 Learning Resources

- [MDN Web Docs](https://developer.mozilla.org/)
- [CSS-Tricks](https://css-tricks.com/)
- [JavaScript.info](https://javascript.info/)
- [Responsive Design](https://responsivedesign.is/)

## 📞 Support Resources

- Browser DevTools (F12) - Built-in debugging
- GitHub Issues - Ask community
- Stack Overflow - Programming help
- ChatGPT/AI - Code assistance

---

**Remember**: Always test changes locally before deploying to production!

Last Updated: November 2025 | Version 1.0.0
