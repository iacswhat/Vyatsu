package education.AssettoCorsaParser.repository.participant;

import education.AssettoCorsaParser.entity.participant.Team;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeamRepository extends JpaRepository<Team, Long> {
  Optional<Team> findByName(String name);
}
