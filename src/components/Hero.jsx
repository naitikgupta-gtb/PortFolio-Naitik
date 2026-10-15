import { Github, Linkedin } from "lucide-react";

function Hero({ data }) {
  return (
    <section id="home" className="hero">
      <div className="glow glow-purple"></div>
      <div className="glow glow-blue"></div>

      <div className="container hero-inner">
        <div>
          <p className="hero-greeting">Hi, I&apos;m {data.name}</p>
          <h1 className="hero-title gradient-text">{data.role}</h1>
          <p className="hero-text">{data.tagline}</p>

          <a href="#projects" className="btn btn-primary">
            Explore My Work
          </a>

          <div className="social-icons">
            <a
              className="icon-link"
              href={data.socials.github}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="GitHub"
            >
              <Github size={20} />
            </a>
            <a
              className="icon-link"
              href={data.socials.linkedin}
              target="_blank"
              rel="noopener noreferrer"
              aria-label="LinkedIn"
            >
              <Linkedin size={20} />
            </a>
          </div>
        </div>

        <div className="hero-photo">
          <img src={data.profileImage} alt={data.name} />
        </div>
      </div>
    </section>
  );
}

export default Hero;