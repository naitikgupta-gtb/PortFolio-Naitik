import { Github, ExternalLink } from "lucide-react";

function ProjectCard({ project }) {
  return (
    <div className="card project-card">
      <div className="project-image">
        {project.image ? (
          <img src={project.image} alt={project.title} />
        ) : (
          <div className="image-placeholder">
            {project.title ? project.title.charAt(0) : "?"}
          </div>
        )}
      </div>

      <h3>{project.title}</h3>
      <p className="muted">{project.description}</p>

      <div className="badges">
        {project.technologies.map((tech) => (
          <span className="badge small" key={tech}>
            {tech}
          </span>
        ))}
      </div>

      <div className="project-links">
        <a
          className="btn btn-ghost btn-small"
          href={project.github}
          target="_blank"
          rel="noopener noreferrer"
          aria-label={`${project.title} GitHub`}
        >
          <Github size={16} />
        </a>
        <a
          className="btn btn-primary btn-small"
          href={project.demo || project.github}
          target="_blank"
          rel="noopener noreferrer"
          aria-label={`${project.title} Live demo`}
        >
          <ExternalLink size={16} />
        </a>
      </div>
    </div>
  );
}

export default ProjectCard;