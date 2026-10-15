import { Mail, Github, Linkedin } from "lucide-react";

function Contact({ email, socials }) {
  return (
    <section id="contact" className="section dark-section">
      <div className="container">
        <div className="card contact-card">
          <h2 className="section-title">
            let&apos;s<span className="gradient-text">Contact</span>
          </h2>
          <p className="muted">I&apos;m open to internship and junior roles.</p>

          <div className="contact-links">
            <a className="icon-link icon-link-text" href={`mailto:${email}`}>
              <Mail size={18} />
              {email}
            </a>
            <a
              className="icon-link icon-link-text"
              href={socials.github}
              target="_blank"
              rel="noopener noreferrer"
            >
              <Github size={18} />
              GitHub
            </a>
            <a
              className="icon-link icon-link-text"
              href={socials.linkedin}
              target="_blank"
              rel="noopener noreferrer"
            >
              <Linkedin size={18} />
              LinkedIn
            </a>
          </div>

          <a className="btn btn-primary" href={`mailto:${email}`}>
            Contact Me
          </a>
        </div>
      </div>
    </section>
  );
}

export default Contact;